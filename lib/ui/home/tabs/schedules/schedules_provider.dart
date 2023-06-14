
import 'package:arsenalfc_flutter/model/fixtures/FixturesResponse.dart';
import 'package:arsenalfc_flutter/model/standing/StandingResponse.dart';
import 'package:get/get.dart';

class ScheduleProvider extends GetConnect{
  var header = {
    "x-rapidapi-key" : "d43e6b99a7mshbd0fa3efd8da2bfp15175cjsn935816567eaf",
    "x-rapidapi-host" : "api-football-v1.p.rapidapi.com"
  };

  var queryParam = {
    "season" : "2022",
    "team" : "42"
  };

  var queryRanking = {
    "season" : "2022",
    "league" : "39"
  };

  var queryResult = {
    "season" : "2023",
    "league" : "39"
  };


  Future<Response<FixturesResponse>> getFixtures() => get("https://api-football-v1.p.rapidapi.com/v3/fixtures",headers: header,
      query: queryParam,decoder: (obj) => FixturesResponse.fromJson(obj));


  Future<Response<FixturesResponse>> getResults() => get("https://api-football-v1.p.rapidapi.com/v3/fixtures",headers: header,
      query: queryResult,decoder: (obj) => FixturesResponse.fromJson(obj));

  Future<Response<StandingResponse>> getRankClb() => get("https://api-football-v1.p.rapidapi.com/v3/standings",headers: header,
      query: queryRanking,decoder: (obj) => StandingResponse.fromJson(obj));

}