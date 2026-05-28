import '../../core/error/result.dart';
import '../entities/fixture.dart';
import '../entities/standing.dart';

abstract interface class ScheduleRepository {
  /// Trận sắp tới của Arsenal.
  Future<Result<List<Fixture>>> getUpcomingFixtures({int limit = 10});

  /// Trận đã đá xong.
  Future<Result<List<Fixture>>> getResults({int limit = 10});

  /// Bảng xếp hạng giải Premier League (mùa hiện tại).
  Future<Result<List<Standing>>> getStandings();

  /// Stream realtime một trận đang live (Firestore `cache/live_match/{id}`).
  Stream<Result<Fixture>> watchLiveMatch(int fixtureId);
}
