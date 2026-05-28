import 'package:gooner_vietnam/core/config/env.dart';
import 'package:gooner_vietnam/model/fixtures/FixturesResponse.dart';
import 'package:gooner_vietnam/model/standing/StandingResponse.dart';
import 'package:get/get.dart';

/// Constants Arsenal / Premier League. Mùa lấy theo năm bắt đầu (2025-26 → 2025).
class _FootballRefs {
  static const arsenalTeamId = '42';
  static const premierLeagueId = '39';
  static const currentSeason = '2025';
}

/// @deprecated Phase 4: đọc từ Firestore `/cache/*`, không gọi api-football từ mobile.
class ScheduleProvider extends GetConnect {
  Map<String, String> get _headers => Env.footballHeaders;

  final Map<String, String> _queryFixtures = {
    'season': _FootballRefs.currentSeason,
    'team': _FootballRefs.arsenalTeamId,
  };

  final Map<String, String> _queryStandings = {
    'season': _FootballRefs.currentSeason,
    'league': _FootballRefs.premierLeagueId,
  };

  String get _baseUrl => Env.footballBaseUrl;

  Future<Response<FixturesResponse>> getFixtures() {
    if (!Env.allowDirectFootballApi) {
      return Future.value(const Response(statusCode: 503));
    }
    return get(
      '$_baseUrl/fixtures',
      headers: _headers,
      query: _queryFixtures,
      decoder: (obj) => FixturesResponse.fromJson(obj),
    );
  }

  Future<Response<FixturesResponse>> getResults() {
    if (!Env.allowDirectFootballApi) {
      return Future.value(const Response(statusCode: 503));
    }
    return get(
      '$_baseUrl/fixtures',
      headers: _headers,
      query: _queryFixtures,
      decoder: (obj) => FixturesResponse.fromJson(obj),
    );
  }

  Future<Response<StandingResponse>> getRankClb() {
    if (!Env.allowDirectFootballApi) {
      return Future.value(const Response(statusCode: 503));
    }
    return get(
      '$_baseUrl/standings',
      headers: _headers,
      query: _queryStandings,
      decoder: (obj) => StandingResponse.fromJson(obj),
    );
  }
}
