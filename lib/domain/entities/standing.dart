import 'fixture.dart' show TeamRef;

class Standing {
  const Standing({
    required this.rank,
    required this.team,
    required this.played,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.points,
    this.form,
  });

  final int rank;
  final TeamRef team;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final int points;
  final String? form;

  int get goalDifference => goalsFor - goalsAgainst;

  @override
  bool operator ==(Object other) =>
      other is Standing && other.team.id == team.id;

  @override
  int get hashCode => team.id.hashCode;
}
