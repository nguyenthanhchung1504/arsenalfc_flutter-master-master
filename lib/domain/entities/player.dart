enum PlayerPosition { goalkeeper, defender, midfielder, attacker, unknown }

class PlayerStats {
  const PlayerStats({
    this.appearances = 0,
    this.goals = 0,
    this.assists = 0,
    this.yellowCards = 0,
    this.redCards = 0,
  });

  final int appearances;
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;
}

class Player {
  const Player({
    required this.id,
    required this.name,
    this.shirtNumber,
    this.position = PlayerPosition.unknown,
    this.photoUrl,
    this.nationality,
    this.dateOfBirth,
    this.stats = const PlayerStats(),
  });

  /// Document id trên Firestore.
  final String id;
  final String name;
  final int? shirtNumber;
  final PlayerPosition position;
  final String? photoUrl;
  final String? nationality;
  final DateTime? dateOfBirth;
  final PlayerStats stats;

  @override
  bool operator ==(Object other) => other is Player && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
