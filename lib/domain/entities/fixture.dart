/// Trạng thái trận đấu chuẩn (mapping từ api-football).
enum FixtureStatus {
  notStarted, // NS, TBD
  live, // 1H, HT, 2H, ET, P
  finished, // FT, AET, PEN
  postponed, // PST
  cancelled, // CANC, ABD
  unknown;

  static FixtureStatus fromShort(String? short) {
    return switch (short) {
      'NS' || 'TBD' => FixtureStatus.notStarted,
      '1H' || 'HT' || '2H' || 'ET' || 'P' || 'BT' || 'LIVE' => FixtureStatus.live,
      'FT' || 'AET' || 'PEN' => FixtureStatus.finished,
      'PST' || 'SUSP' || 'INT' => FixtureStatus.postponed,
      'CANC' || 'ABD' || 'AWD' || 'WO' => FixtureStatus.cancelled,
      _ => FixtureStatus.unknown,
    };
  }
}

class TeamRef {
  const TeamRef({required this.id, required this.name, this.logoUrl});

  final int id;
  final String name;
  final String? logoUrl;
}

class Fixture {
  const Fixture({
    required this.id,
    required this.kickoffAt,
    required this.status,
    required this.homeTeam,
    required this.awayTeam,
    this.leagueId,
    this.leagueName,
    this.round,
    this.venue,
    this.homeGoals,
    this.awayGoals,
    this.elapsedMinutes,
  });

  final int id;
  final DateTime kickoffAt;
  final FixtureStatus status;
  final TeamRef homeTeam;
  final TeamRef awayTeam;
  final int? leagueId;
  final String? leagueName;
  final String? round;
  final String? venue;
  final int? homeGoals;
  final int? awayGoals;
  final int? elapsedMinutes;

  bool get isFinished => status == FixtureStatus.finished;
  bool get isLive => status == FixtureStatus.live;

  @override
  bool operator ==(Object other) => other is Fixture && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
