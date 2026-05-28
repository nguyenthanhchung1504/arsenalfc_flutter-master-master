/// Hằng số TheSportsDB cho Arsenal / Premier League.
class FootballConstants {
  FootballConstants._();

  /// `idTeam` của Arsenal trên TheSportsDB.
  static const int arsenalTeamId = 133604;

  /// `idLeague` của English Premier League trên TheSportsDB.
  static const int premierLeagueId = 4328;

  /// Mùa hiện tại theo định dạng TheSportsDB ("2025-2026").
  static String get currentSeason {
    final now = DateTime.now();
    final start = now.month >= 7 ? now.year : now.year - 1;
    return '$start-${start + 1}';
  }
}
