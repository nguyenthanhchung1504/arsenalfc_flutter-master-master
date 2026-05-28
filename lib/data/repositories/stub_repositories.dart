import '../../core/error/failure.dart';
import '../../core/error/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/fixture.dart';
import '../../domain/entities/paginated.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/standing.dart';
import '../../domain/entities/video.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/player_repository.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../../domain/repositories/video_repository.dart';

/// Stub repositories — Phase 3/4 sẽ thay bằng impl Firestore thật.

class StubVideoRepository implements VideoRepository {
  const StubVideoRepository();

  @override
  Future<Result<Paginated<Video>>> getVideos({
    int pageSize = 20,
    Object? cursor,
  }) async =>
      const Err(NotImplementedFailure('Video chưa kết nối Firestore.'));

  @override
  Future<Result<Video>> getVideoById(String id) async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<List<Video>>> getRelated(String videoId, {int limit = 5}) async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<List<Video>>> search(String query, {int limit = 20}) async =>
      const Err(NotImplementedFailure());
}

class StubScheduleRepository implements ScheduleRepository {
  const StubScheduleRepository();

  @override
  Future<Result<List<Fixture>>> getUpcomingFixtures({int limit = 10}) async =>
      const Err(NotImplementedFailure('Lịch thi đấu chờ Cloud Functions.'));

  @override
  Future<Result<List<Fixture>>> getResults({int limit = 10}) async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<List<Standing>>> getStandings() async =>
      const Err(NotImplementedFailure());

  @override
  Stream<Result<Fixture>> watchLiveMatch(int fixtureId) =>
      Stream.value(const Err(NotImplementedFailure()));
}

class StubPlayerRepository implements PlayerRepository {
  const StubPlayerRepository();

  @override
  Future<Result<List<Player>>> getSquad() async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<Player>> getPlayerById(String id) async =>
      const Err(NotImplementedFailure());
}

class StubAuthRepository implements AuthRepository {
  const StubAuthRepository();

  @override
  Stream<AppUser?> authStateChanges() => const Stream.empty();

  @override
  AppUser? get currentUser => null;

  @override
  Future<Result<AppUser>> signInWithEmail({
    required String email,
    required String password,
  }) async =>
      const Err(NotImplementedFailure('Auth chưa kết nối Firebase.'));

  @override
  Future<Result<AppUser>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<AppUser>> signInWithGoogle() async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<AppUser>> signInWithApple() async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<AppUser>> signInAnonymously() async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<void>> signOut() async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<void>> sendPasswordReset(String email) async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<AppUser>> updateProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async =>
      const Err(NotImplementedFailure());
}
