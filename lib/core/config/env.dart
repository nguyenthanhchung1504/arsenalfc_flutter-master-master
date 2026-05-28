import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Loại provider api-football đang dùng.
enum FootballApiProvider { apisports, rapidapi }

/// Biến môi trường — đọc từ `.env` (dev) hoặc để trống trên production.
/// Không hardcode secret trong source.
class Env {
  Env._();

  static String _read(String key, [String fallback = '']) =>
      dotenv.maybeGet(key) ?? fallback;

  // ───── api-football ─────────────────────────────────────────────

  static FootballApiProvider get footballProvider {
    final v = _read('APIFOOTBALL_PROVIDER', 'apisports').toLowerCase();
    return v == 'rapidapi'
        ? FootballApiProvider.rapidapi
        : FootballApiProvider.apisports;
  }

  static String get footballBaseUrl =>
      _read('APIFOOTBALL_BASE_URL', 'https://v3.football.api-sports.io');

  static String get footballApiKey => _read('APIFOOTBALL_KEY');

  static String get footballRapidApiHost =>
      _read('APIFOOTBALL_RAPIDAPI_HOST', 'api-football-v1.p.rapidapi.com');

  /// Header chuẩn để gọi api-football theo provider.
  static Map<String, String> get footballHeaders {
    if (footballApiKey.isEmpty) return const {};
    switch (footballProvider) {
      case FootballApiProvider.apisports:
        return {'x-apisports-key': footballApiKey};
      case FootballApiProvider.rapidapi:
        return {
          'x-rapidapi-key': footballApiKey,
          'x-rapidapi-host': footballRapidApiHost,
        };
    }
  }

  /// Production: luôn false. Debug + có key trong `.env` mới gọi API trực tiếp.
  /// Production sẽ đọc Firestore `/cache/*` (Phase 4).
  static bool get allowDirectFootballApi =>
      kDebugMode && footballApiKey.isNotEmpty;
}
