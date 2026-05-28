import * as admin from 'firebase-admin';
import { onDocumentWritten } from 'firebase-functions/v2/firestore';
import { onRequest } from 'firebase-functions/v2/https';
import { onSchedule } from 'firebase-functions/v2/scheduler';
import {
  syncAllFootballCache,
  syncFixturesCache,
  syncLiveMatches,
  syncStandingsCache,
} from './cache';

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();
const region = 'asia-southeast1';

/** Cache lịch + kết quả Arsenal — 12h/lần. */
export const cronFixtures = onSchedule(
  {
    schedule: '0 */12 * * *',
    timeZone: 'Asia/Ho_Chi_Minh',
    region,
  },
  async () => {
    const count = await syncFixturesCache();
    console.log(`cronFixtures: synced ${count} fixtures`);
  },
);

/** BXH Premier League — 6h/lần. */
export const cronStandings = onSchedule(
  {
    schedule: '0 */6 * * *',
    timeZone: 'Asia/Ho_Chi_Minh',
    region,
  },
  async () => {
    const count = await syncStandingsCache();
    console.log(`cronStandings: synced ${count} teams`);
  },
);

/** Trận Arsenal đang live — 5 phút/lần (fallback eventsnext). */
export const cronLiveMatch = onSchedule(
  {
    schedule: '*/5 * * * *',
    timeZone: 'Asia/Ho_Chi_Minh',
    region,
  },
  async () => {
    const count = await syncLiveMatches();
    console.log(`cronLiveMatch: updated ${count} live docs`);
  },
);

/** HTTP đồng bộ thủ công (test). */
export const httpsSyncFootball = onRequest({ region }, async (_req, res) => {
  try {
    const result = await syncAllFootballCache();
    res.json({ ok: true, ...result });
  } catch (e) {
    console.error(e);
    res.status(500).json({ ok: false, error: String(e) });
  }
});

/** FCM topic `live_match` khi có bàn thắng mới. */
export const onLiveMatchWrite = onDocumentWritten(
  { document: 'cache/{docId}', region },
  async (event) => {
    const docId = event.params.docId as string;
    if (!docId.startsWith('live_')) return;

    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!after) return;

    const beforeGoals = (before?.home_goals ?? 0) + (before?.away_goals ?? 0);
    const afterGoals = (after.home_goals ?? 0) + (after.away_goals ?? 0);
    if (afterGoals <= beforeGoals) return;

    const home = after.home_team?.name ?? 'Home';
    const away = after.away_team?.name ?? 'Away';
    const score = `${after.home_goals ?? 0} - ${after.away_goals ?? 0}`;

    await admin.messaging().send({
      topic: 'live_match',
      notification: {
        title: `⚽ ${home} vs ${away}`,
        body: `Tỷ số: ${score}`,
      },
      data: { fixtureId: String(after.id ?? ''), type: 'goal' },
    });

    await db.collection('notifications').add({
      type: 'live_goal',
      fixture_id: after.id,
      title: `${home} vs ${away}`,
      body: `Tỷ số: ${score}`,
      created_at: admin.firestore.FieldValue.serverTimestamp(),
    });
  },
);
