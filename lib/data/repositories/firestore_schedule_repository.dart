import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_paths.dart';
import '../../core/error/failure.dart';
import '../../core/error/result.dart';
import '../../core/utils/firestore_parse.dart';
import '../../domain/entities/fixture.dart';
import '../../domain/entities/standing.dart';
import '../../domain/repositories/schedule_repository.dart';

class FirestoreScheduleRepository implements ScheduleRepository {
  FirestoreScheduleRepository(this._db);

  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> get _fixturesDoc =>
      _db.doc(FirestorePaths.cacheFixtures);

  DocumentReference<Map<String, dynamic>> get _standingsDoc =>
      _db.doc(FirestorePaths.cacheStandings);

  @override
  Future<Result<List<Fixture>>> getUpcomingFixtures({int limit = 10}) async {
    return guard(() async {
      final items = await _loadFixtures();
      final now = DateTime.now();
      final upcoming = items
          .where(
            (f) =>
                !f.isFinished &&
                f.status != FixtureStatus.cancelled &&
                f.status != FixtureStatus.postponed &&
                f.kickoffAt.isAfter(now.subtract(const Duration(hours: 2))),
          )
          .toList()
        ..sort((a, b) => a.kickoffAt.compareTo(b.kickoffAt));
      return upcoming.take(limit).toList();
    }, onError: _mapError);
  }

  @override
  Future<Result<List<Fixture>>> getResults({int limit = 10}) async {
    return guard(() async {
      final items = await _loadFixtures();
      final results = items.where((f) => f.isFinished).toList()
        ..sort((a, b) => b.kickoffAt.compareTo(a.kickoffAt));
      return results.take(limit).toList();
    }, onError: _mapError);
  }

  @override
  Future<Result<List<Standing>>> getStandings() async {
    return guard(() async {
      final snap = await _standingsDoc.get();
      if (!snap.exists) {
        throw const ValidationFailure(
          'Chưa có dữ liệu bảng xếp hạng. Vui lòng thử lại sau.',
        );
      }
      final data = snap.data() ?? {};
      final rawItems = data['items'] as List<dynamic>? ?? [];
      return rawItems
          .map((e) => _parseStanding(e as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.rank.compareTo(b.rank));
    }, onError: _mapError);
  }

  @override
  Stream<Result<Fixture>> watchLiveMatch(int fixtureId) {
    return _db
        .doc(FirestorePaths.cacheLiveMatch('$fixtureId'))
        .snapshots()
        .map((snap) {
      if (!snap.exists) {
        return const Err<Fixture>(
          ValidationFailure('Trận đấu không còn live.'),
        );
      }
      return Ok(_parseFixture(snap.data() ?? {}));
    });
  }

  Future<List<Fixture>> _loadFixtures() async {
    final snap = await _fixturesDoc.get();
    if (!snap.exists) {
      throw const ValidationFailure(
        'Chưa có dữ liệu lịch thi đấu. Vui lòng thử lại sau.',
      );
    }
    final data = snap.data() ?? {};
    final rawItems = data['items'] as List<dynamic>? ?? [];
    return rawItems
        .map((e) => _parseFixture(e as Map<String, dynamic>))
        .toList();
  }

  Fixture _parseFixture(Map<String, dynamic> data) {
    final home = data['home_team'] as Map<String, dynamic>? ?? {};
    final away = data['away_team'] as Map<String, dynamic>? ?? {};

    return Fixture(
      id: (data['id'] as num).toInt(),
      kickoffAt: parseFirestoreDate(data['kickoff_at']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      status: FixtureStatus.fromShort(data['status_short'] as String?),
      homeTeam: TeamRef(
        id: (home['id'] as num).toInt(),
        name: home['name'] as String? ?? '',
        logoUrl: home['logo_url'] as String?,
      ),
      awayTeam: TeamRef(
        id: (away['id'] as num).toInt(),
        name: away['name'] as String? ?? '',
        logoUrl: away['logo_url'] as String?,
      ),
      leagueId: (data['league_id'] as num?)?.toInt(),
      leagueName: data['league_name'] as String?,
      round: data['round'] as String?,
      venue: data['venue'] as String?,
      homeGoals: (data['home_goals'] as num?)?.toInt(),
      awayGoals: (data['away_goals'] as num?)?.toInt(),
      elapsedMinutes: (data['elapsed_minutes'] as num?)?.toInt(),
    );
  }

  Standing _parseStanding(Map<String, dynamic> data) {
    final team = data['team'] as Map<String, dynamic>? ?? {};
    return Standing(
      rank: (data['rank'] as num).toInt(),
      team: TeamRef(
        id: (team['id'] as num).toInt(),
        name: team['name'] as String? ?? '',
        logoUrl: team['logo_url'] as String?,
      ),
      played: (data['played'] as num).toInt(),
      wins: (data['wins'] as num).toInt(),
      draws: (data['draws'] as num).toInt(),
      losses: (data['losses'] as num).toInt(),
      goalsFor: (data['goals_for'] as num).toInt(),
      goalsAgainst: (data['goals_against'] as num).toInt(),
      points: (data['points'] as num).toInt(),
      form: data['form'] as String?,
    );
  }

  Failure _mapError(Object error, StackTrace stack) {
    if (error is Failure) return error;
    return DatabaseFailure(cause: error, stackTrace: stack);
  }
}
