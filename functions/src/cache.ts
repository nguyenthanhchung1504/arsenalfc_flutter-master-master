import * as admin from 'firebase-admin';
import {
  ARSENAL_TEAM_ID,
  currentSeason,
  PL_TOTAL_ROUNDS,
  PREMIER_LEAGUE_ID,
} from './config';
import { tsdbGet } from './thesportsdb';
import {
  CachedFixture,
  CachedLiveMatch,
  CachedStanding,
  isLiveStatus,
  mapTsdbEvent,
  mapTsdbStandingRow,
} from './mappers';

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

type TsdbEventsResponse = { events?: unknown[]; results?: unknown[] };
type TsdbTableResponse = { table?: unknown[] };

/** Gọi `eventsround.php` cho từng vòng 1..38 và gộp lại. */
async function fetchAllLeagueFixtures(season: string): Promise<CachedFixture[]> {
  const results: CachedFixture[] = [];
  for (let round = 1; round <= PL_TOTAL_ROUNDS; round += 1) {
    const res = await tsdbGet<TsdbEventsResponse>('/eventsround.php', {
      id: PREMIER_LEAGUE_ID,
      r: round,
      s: season,
    });
    const events = res.events ?? [];
    for (const ev of events) {
      results.push(mapTsdbEvent(ev));
    }
  }
  return results;
}

export async function syncFixturesCache(): Promise<number> {
  const season = currentSeason();
  const all = await fetchAllLeagueFixtures(season);
  const arsenalOnly = all.filter(
    (f) =>
      f.home_team.id === ARSENAL_TEAM_ID || f.away_team.id === ARSENAL_TEAM_ID,
  );

  await db.doc('cache/fixtures').set({
    season,
    team_id: ARSENAL_TEAM_ID,
    updated_at: admin.firestore.FieldValue.serverTimestamp(),
    items: arsenalOnly,
  });

  return arsenalOnly.length;
}

export async function syncStandingsCache(): Promise<number> {
  const season = currentSeason();
  const res = await tsdbGet<TsdbTableResponse>('/lookuptable.php', {
    l: PREMIER_LEAGUE_ID,
    s: season,
  });
  const rows = res.table ?? [];
  const items: CachedStanding[] = rows.map(mapTsdbStandingRow);

  await db.doc('cache/standings').set({
    season,
    league_id: PREMIER_LEAGUE_ID,
    updated_at: admin.firestore.FieldValue.serverTimestamp(),
    items,
  });

  return items.length;
}

/** TheSportsDB free không có livescore — fallback: dùng `eventsnext` để biết trận hôm nay. */
export async function syncLiveMatches(): Promise<number> {
  const res = await tsdbGet<TsdbEventsResponse>('/eventsnext.php', {
    id: ARSENAL_TEAM_ID,
  });
  const events = res.events ?? [];
  let updated = 0;
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setUTCDate(today.getUTCDate() + 1);

  for (const ev of events) {
    const fixture = mapTsdbEvent(ev);
    const kickoff = new Date(fixture.kickoff_at);
    if (Number.isNaN(kickoff.getTime())) continue;

    const diffMin = (kickoff.getTime() - today.getTime()) / 60000;
    if (diffMin > 120 || diffMin < -180) continue;

    if (!isLiveStatus(fixture.status_short) &&
        fixture.status_short !== 'NS') continue;

    const payload: CachedLiveMatch = { ...fixture, events: [] };
    await db.doc(`cache/live_${fixture.id}`).set({
      ...payload,
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
    });
    updated += 1;
  }

  return updated;
}

export async function syncAllFootballCache() {
  const fixtures = await syncFixturesCache();
  const standings = await syncStandingsCache();
  const live = await syncLiveMatches();
  return { fixtures, standings, live };
}
