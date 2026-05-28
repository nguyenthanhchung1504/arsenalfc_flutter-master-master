#!/usr/bin/env python3
"""Seed cache/fixtures + cache/standings từ TheSportsDB (key test public `3`)."""
from __future__ import annotations

import json
import re
import sys
import time
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

PROJECT = "afcvn-app"
ARSENAL_ID = 133604
PREMIER_LEAGUE_ID = 4328
PL_TOTAL_ROUNDS = 38
TSDB_BASE = "https://www.thesportsdb.com/api/v1/json/3"


def load_firebase_token() -> str:
    cfg = Path.home() / ".config/configstore/firebase-tools.json"
    data = json.loads(cfg.read_text())
    return data["tokens"]["access_token"]


def current_season() -> str:
    now = datetime.now(timezone.utc)
    start = now.year if now.month >= 7 else now.year - 1
    return f"{start}-{start + 1}"


def tsdb_get(path: str, query: dict, retries: int = 6) -> dict:
    qs = "&".join(f"{k}={v}" for k, v in query.items())
    url = f"{TSDB_BASE}{path}?{qs}"
    for attempt in range(retries + 1):
        req = urllib.request.Request(url)
        try:
            with urllib.request.urlopen(req, timeout=60) as res:
                return json.loads(res.read())
        except urllib.error.HTTPError as e:
            if e.code == 429 and attempt < retries:
                wait = min(15, 5 + attempt * 5)
                print(f"    429 — đợi {wait}s rồi thử lại …", file=sys.stderr)
                time.sleep(wait)
                continue
            raise
    raise RuntimeError("unreachable")


def normalize_status(raw: str | None) -> str:
    if not raw:
        return "NS"
    raw = raw.strip()
    if raw in ("Match Finished", "FT"):
        return "FT"
    if raw in ("Not Started", "NS", "TBD"):
        return "NS"
    if raw in ("Postponed", "PST"):
        return "PST"
    if raw in ("Cancelled", "CANC"):
        return "CANC"
    if raw in ("1H", "HT", "2H", "ET", "P", "Live", "In Progress"):
        return "LIVE"
    return raw.upper()


def to_int(v) -> int | None:
    if v is None or v == "":
        return None
    try:
        return int(v)
    except (TypeError, ValueError):
        return None


def to_int0(v) -> int:
    n = to_int(v)
    return n if n is not None else 0


def map_event(ev: dict) -> dict:
    return {
        "id": to_int0(ev.get("idEvent")),
        "kickoff_at": ev.get("strTimestamp") or ev.get("dateEvent") or "",
        "status_short": normalize_status(ev.get("strStatus")),
        "home_team": {
            "id": to_int0(ev.get("idHomeTeam")),
            "name": ev.get("strHomeTeam") or "",
            "logo_url": ev.get("strHomeTeamBadge"),
        },
        "away_team": {
            "id": to_int0(ev.get("idAwayTeam")),
            "name": ev.get("strAwayTeam") or "",
            "logo_url": ev.get("strAwayTeamBadge"),
        },
        "league_id": to_int0(ev.get("idLeague")) or None,
        "league_name": ev.get("strLeague"),
        "round": str(ev["intRound"]) if ev.get("intRound") else None,
        "venue": ev.get("strVenue"),
        "home_goals": to_int(ev.get("intHomeScore")),
        "away_goals": to_int(ev.get("intAwayScore")),
        "elapsed_minutes": to_int(ev.get("strProgress")),
    }


def map_standing(row: dict) -> dict:
    return {
        "rank": to_int0(row.get("intRank")),
        "team": {
            "id": to_int0(row.get("idTeam")),
            "name": row.get("strTeam") or "",
            "logo_url": row.get("strBadge"),
        },
        "played": to_int0(row.get("intPlayed")),
        "wins": to_int0(row.get("intWin")),
        "draws": to_int0(row.get("intDraw")),
        "losses": to_int0(row.get("intLoss")),
        "goals_for": to_int0(row.get("intGoalsFor")),
        "goals_against": to_int0(row.get("intGoalsAgainst")),
        "points": to_int0(row.get("intPoints")),
        "form": row.get("strForm"),
    }


def collect_arsenal_fixtures(season: str) -> list[dict]:
    all_events: list[dict] = []
    for r in range(1, PL_TOTAL_ROUNDS + 1):
        try:
            data = tsdb_get("/eventsround.php", {"id": PREMIER_LEAGUE_ID, "r": r, "s": season})
        except Exception as e:
            print(f"  round {r} lỗi: {e}", file=sys.stderr)
            continue
        events = data.get("events") or []
        for ev in events:
            mapped = map_event(ev)
            if (
                mapped["home_team"]["id"] == ARSENAL_ID
                or mapped["away_team"]["id"] == ARSENAL_ID
            ):
                all_events.append(mapped)
        time.sleep(1.0)
    all_events.sort(key=lambda e: e["kickoff_at"])
    return all_events


def collect_standings(season: str) -> list[dict]:
    data = tsdb_get("/lookuptable.php", {"l": PREMIER_LEAGUE_ID, "s": season})
    rows = data.get("table") or []
    return [map_standing(r) for r in rows]


def to_firestore_value(v):
    if v is None:
        return {"nullValue": None}
    if isinstance(v, bool):
        return {"booleanValue": v}
    if isinstance(v, int):
        return {"integerValue": str(v)}
    if isinstance(v, float):
        return {"doubleValue": v}
    if isinstance(v, str):
        if re.match(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}", v):
            iso = v if v.endswith("Z") or "+" in v[10:] else v + "Z"
            return {"timestampValue": iso}
        return {"stringValue": v}
    if isinstance(v, list):
        return {"arrayValue": {"values": [to_firestore_value(i) for i in v]}}
    if isinstance(v, dict):
        return {
            "mapValue": {
                "fields": {k: to_firestore_value(val) for k, val in v.items()},
            }
        }
    raise TypeError(type(v))


def firestore_set(doc_path: str, fields: dict, token: str):
    qs = "&".join(f"updateMask.fieldPaths={k}" for k in fields.keys())
    url = (
        f"https://firestore.googleapis.com/v1/projects/{PROJECT}/"
        f"databases/(default)/documents/{doc_path}?{qs}"
    )
    payload = {"fields": {k: to_firestore_value(v) for k, v in fields.items()}}
    req = urllib.request.Request(
        url,
        data=json.dumps(payload).encode(),
        headers={
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json",
        },
        method="PATCH",
    )
    with urllib.request.urlopen(req, timeout=60) as res:
        return json.loads(res.read())


def main():
    token = load_firebase_token()
    season = current_season()

    print(f"Season: {season}")
    print("Đang lấy fixtures Arsenal qua TheSportsDB ...")
    fixtures = collect_arsenal_fixtures(season)
    print(f"  → {len(fixtures)} fixtures")

    print("Đang lấy bảng xếp hạng Premier League ...")
    standings = collect_standings(season)
    print(f"  → {len(standings)} teams")

    now_iso = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

    firestore_set(
        "cache/fixtures",
        {
            "season": season,
            "team_id": ARSENAL_ID,
            "updated_at": now_iso,
            "items": fixtures,
        },
        token,
    )
    firestore_set(
        "cache/standings",
        {
            "season": season,
            "league_id": PREMIER_LEAGUE_ID,
            "updated_at": now_iso,
            "items": standings,
        },
        token,
    )

    print(
        f"\nĐã ghi Firestore: cache/fixtures ({len(fixtures)} trận), "
        f"cache/standings ({len(standings)} đội)"
    )
    if len(standings) < 20:
        print(
            "⚠️  TheSportsDB free key 3 chỉ trả top 5 bảng xếp hạng. "
            "Nâng cấp Patreon (~$3/tháng) để có đủ 20 đội."
        )


if __name__ == "__main__":
    main()
