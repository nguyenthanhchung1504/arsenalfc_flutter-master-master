# Phase 4 — Cloud Functions + Lịch thi đấu

Nguồn dữ liệu: **TheSportsDB** (https://www.thesportsdb.com) — public free key `3`.

## 1. Lý do đổi từ api-football → TheSportsDB

api-football gói **Free** chỉ có dữ liệu mùa **2022–2024**, không lấy được mùa hiện tại 2025–26. TheSportsDB free key cho phép lấy đủ lịch + kết quả mùa hiện tại, **BXH giới hạn top 5**.

> Muốn full BXH 20 đội → Patreon TheSportsDB ~$3/tháng (key V2, không cần đổi code, chỉ đổi `TSDB_API_BASE`).

## 2. Schema Firestore (snake_case)

```
cache/fixtures        ← lịch + kết quả Arsenal
  season: "2025-2026"
  team_id: 133604
  items: [{ id, kickoff_at, status_short, home_team, away_team,
            league_id, league_name, round, venue, home_goals, away_goals, … }]
  updated_at: timestamp

cache/standings       ← BXH PL (top 5 ở gói free)
  season: "2025-2026"
  league_id: 4328
  items: [{ rank, team, played, wins, draws, losses,
            goals_for, goals_against, points, form }]

cache/live_{id}       ← trận đang/sắp diễn ra (ghi bởi cronLiveMatch)
```

## 3. Seed nhanh từ máy dev

```bash
firebase login --reauth          # nếu token hết hạn
python3 scripts/seed_football_cache.py
```

Script sẽ tự đăng nhập qua firebase-tools token, lấy 38 vòng Premier League rồi ghi Firestore.

## 4. Cloud Functions

| Function | Trigger | Mô tả |
|---|---|---|
| `cronFixtures` | Cloud Scheduler 12h/lần | Cập nhật `cache/fixtures` |
| `cronStandings` | Cloud Scheduler 6h/lần | Cập nhật `cache/standings` |
| `cronLiveMatch` | Cloud Scheduler 5 phút | Tạo/cập nhật `cache/live_{id}` quanh giờ kick-off Arsenal |
| `httpsSyncFootball` | HTTP | Đồng bộ thủ công 1 lượt (test) |
| `onLiveMatchWrite` | Firestore | FCM topic `live_match` khi `home_goals + away_goals` tăng |

### Deploy

```bash
cd functions
npm install              # cần Node 20+
npm run build
cd ..
firebase deploy --only functions --project afcvn-app
```

Không cần secret API key (TheSportsDB key `3` là public).

## 5. App Flutter

- Tab **Lịch thi đấu** đọc Firestore `cache/fixtures` + `cache/standings` qua `FirestoreScheduleRepository` — không gọi API ngoài từ mobile.
- Hằng số:
  ```
  FootballConstants.arsenalTeamId   = 133604   // TheSportsDB
  FootballConstants.premierLeagueId = 4328
  FootballConstants.currentSeason   = "2025-2026"
  ```
- FCM topic đăng ký tự động trong `HomeScreen`: `news`, `live_match`.

## 6. Lưu ý

- Free key `3` của TheSportsDB rate-limit ~30 req/phút → script seed có retry/backoff.
- `eventsround.php` trả 10 trận/vòng, lặp 1–38 = 380 trận PL toàn mùa.
- `lookuptable.php` chỉ trả top 5 với key free — đã cảnh báo trong script.
