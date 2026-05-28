/// Đường dẫn Firestore — không hardcode string rải rác trong datasource.
class FirestorePaths {
  FirestorePaths._();

  static const news = 'news';
  static const videos = 'videos';
  static const players = 'players';
  static const users = 'users';

  static const cacheFixtures = 'cache/fixtures';
  static const cacheStandings = 'cache/standings';
  /// Document trong collection `cache` (id: `live_{fixtureId}`).
  static String cacheLiveMatch(String fixtureId) => 'cache/live_$fixtureId';
}
