/* eslint-disable @typescript-eslint/no-explicit-any */

export type CachedFixture = {
  id: number;
  kickoff_at: string;
  status_short: string;
  home_team: { id: number; name: string; logo_url?: string };
  away_team: { id: number; name: string; logo_url?: string };
  league_id?: number;
  league_name?: string;
  round?: string;
  venue?: string;
  home_goals?: number | null;
  away_goals?: number | null;
  elapsed_minutes?: number | null;
};

export type CachedStanding = {
  rank: number;
  team: { id: number; name: string; logo_url?: string };
  played: number;
  wins: number;
  draws: number;
  losses: number;
  goals_for: number;
  goals_against: number;
  points: number;
  form?: string;
};

export type CachedLiveMatch = CachedFixture & {
  events?: Array<{
    time: number;
    team_id: number;
    type: string;
    detail: string;
    player?: string;
  }>;
};

function intOrNull(v: any): number | null {
  if (v === null || v === undefined || v === '') return null;
  const n = Number(v);
  return Number.isNaN(n) ? null : n;
}

function intOrZero(v: any): number {
  const n = intOrNull(v);
  return n ?? 0;
}

/** Chuẩn hoá trạng thái TheSportsDB sang short status quen thuộc. */
export function normalizeStatus(raw: string | null | undefined): string {
  if (!raw) return 'NS';
  const s = raw.trim();
  if (['Match Finished', 'FT'].includes(s)) return 'FT';
  if (['Not Started', 'NS', 'TBD'].includes(s)) return 'NS';
  if (['Postponed', 'PST'].includes(s)) return 'PST';
  if (['Cancelled', 'CANC'].includes(s)) return 'CANC';
  if (['1H', 'HT', '2H', 'ET', 'P', 'Live', 'In Progress'].includes(s)) {
    return 'LIVE';
  }
  return s.toUpperCase();
}

export function mapTsdbEvent(event: any): CachedFixture {
  return {
    id: intOrZero(event.idEvent),
    kickoff_at: event.strTimestamp ?? event.dateEvent ?? '',
    status_short: normalizeStatus(event.strStatus),
    home_team: {
      id: intOrZero(event.idHomeTeam),
      name: event.strHomeTeam ?? '',
      logo_url: event.strHomeTeamBadge ?? undefined,
    },
    away_team: {
      id: intOrZero(event.idAwayTeam),
      name: event.strAwayTeam ?? '',
      logo_url: event.strAwayTeamBadge ?? undefined,
    },
    league_id: intOrZero(event.idLeague) || undefined,
    league_name: event.strLeague ?? undefined,
    round: event.intRound ? String(event.intRound) : undefined,
    venue: event.strVenue ?? undefined,
    home_goals: intOrNull(event.intHomeScore),
    away_goals: intOrNull(event.intAwayScore),
    elapsed_minutes: intOrNull(event.strProgress),
  };
}

export function mapTsdbStandingRow(row: any): CachedStanding {
  return {
    rank: intOrZero(row.intRank),
    team: {
      id: intOrZero(row.idTeam),
      name: row.strTeam ?? '',
      logo_url: row.strBadge ?? undefined,
    },
    played: intOrZero(row.intPlayed),
    wins: intOrZero(row.intWin),
    draws: intOrZero(row.intDraw),
    losses: intOrZero(row.intLoss),
    goals_for: intOrZero(row.intGoalsFor),
    goals_against: intOrZero(row.intGoalsAgainst),
    points: intOrZero(row.intPoints),
    form: row.strForm ?? undefined,
  };
}

export function isLiveStatus(short: string): boolean {
  return short === 'LIVE';
}

export function isFinishedStatus(short: string): boolean {
  return short === 'FT';
}
