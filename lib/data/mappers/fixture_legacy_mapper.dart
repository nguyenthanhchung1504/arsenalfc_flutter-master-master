import '../../domain/entities/fixture.dart' as domain;
import '../../domain/entities/standing.dart' as domain;
import '../../model/fixtures/Away.dart';
import '../../model/fixtures/Fixture.dart' as legacy;
import '../../model/fixtures/FixturesData.dart';
import '../../model/fixtures/Goals.dart';
import '../../model/fixtures/Home.dart' as fixture_home;
import '../../model/fixtures/League.dart';
import '../../model/fixtures/Status.dart';
import '../../model/fixtures/Teams.dart';
import '../../model/fixtures/Venue.dart';
import '../../model/standing/Home.dart' as standing_home;
import '../../model/standing/Standings.dart';
import '../../model/standing/Team.dart' as standing_team;

/// Chuyển entity domain → model legacy cho UI GetX hiện tại.
class FixtureLegacyMapper {
  FixtureLegacyMapper._();

  static FixturesData toFixturesData(domain.Fixture fixture) {
    final f = legacy.Fixture(
      id: fixture.id,
      date: fixture.kickoffAt.toUtc().toIso8601String(),
      venue: fixture.venue != null ? Venue(name: fixture.venue) : null,
      status: Status(
        long: _statusLong(fixture.status),
        short: _statusShort(fixture.status),
        elapsed: fixture.elapsedMinutes,
      ),
    );

    return FixturesData(
      fixture: f,
      league: League(
        id: fixture.leagueId,
        name: fixture.leagueName,
        round: fixture.round,
      ),
      teams: Teams(
        home: fixture_home.Home(
          id: fixture.homeTeam.id,
          name: fixture.homeTeam.name,
          logo: fixture.homeTeam.logoUrl,
        ),
        away: Away(
          id: fixture.awayTeam.id,
          name: fixture.awayTeam.name,
          logo: fixture.awayTeam.logoUrl,
        ),
      ),
      goals: Goals(
        home: fixture.homeGoals,
        away: fixture.awayGoals,
      ),
    );
  }

  static Standings toLegacyStanding(domain.Standing standing) {
    return Standings(
      rank: standing.rank,
      team: standing_team.Team(
        id: standing.team.id,
        name: standing.team.name,
        logo: standing.team.logoUrl,
      ),
      points: standing.points,
      goalsDiff: standing.goalDifference,
      form: standing.form,
      all: standing_home.Home(
        played: standing.played,
        win: standing.wins,
        draw: standing.draws,
        lose: standing.losses,
      ),
    );
  }

  static String _statusShort(domain.FixtureStatus status) {
    return switch (status) {
      domain.FixtureStatus.notStarted => 'NS',
      domain.FixtureStatus.live => 'LIVE',
      domain.FixtureStatus.finished => 'FT',
      domain.FixtureStatus.postponed => 'PST',
      domain.FixtureStatus.cancelled => 'CANC',
      domain.FixtureStatus.unknown => 'NS',
    };
  }

  static String _statusLong(domain.FixtureStatus status) {
    return switch (status) {
      domain.FixtureStatus.notStarted => 'Not Started',
      domain.FixtureStatus.live => 'Live',
      domain.FixtureStatus.finished => 'Match Finished',
      domain.FixtureStatus.postponed => 'Match Postponed',
      domain.FixtureStatus.cancelled => 'Match Cancelled',
      domain.FixtureStatus.unknown => 'Not Started',
    };
  }
}
