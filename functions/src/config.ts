/** Cấu hình ngoài Cloud Functions cho TheSportsDB. */

/** Arsenal trên TheSportsDB. */
export const ARSENAL_TEAM_ID = 133604;

/** English Premier League. */
export const PREMIER_LEAGUE_ID = 4328;

/** Số round/vòng trong 1 mùa PL. */
export const PL_TOTAL_ROUNDS = 38;

/** API base — key `3` là test free public của TheSportsDB. */
export const TSDB_API_BASE = 'https://www.thesportsdb.com/api/v1/json/3';

/** Mùa giải hiện tại theo định dạng TheSportsDB ("2025-2026"). */
export function currentSeason(): string {
  const now = new Date();
  const year = now.getUTCFullYear();
  const month = now.getUTCMonth();
  const startYear = month >= 6 ? year : year - 1;
  return `${startYear}-${startYear + 1}`;
}
