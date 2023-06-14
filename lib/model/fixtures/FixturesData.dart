import 'Fixture.dart';
import 'League.dart';
import 'Teams.dart';
import 'Goals.dart';
import 'Score.dart';

class FixturesData {
  FixturesData({
      this.fixture, 
      this.league, 
      this.teams, 
      this.goals, 
      this.score,});

  FixturesData.fromJson(dynamic json) {
    fixture = json['fixture'] != null ? Fixture.fromJson(json['fixture']) : null;
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    teams = json['teams'] != null ? Teams.fromJson(json['teams']) : null;
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    score = json['score'] != null ? Score.fromJson(json['score']) : null;
  }
  Fixture? fixture;
  League? league;
  Teams? teams;
  Goals? goals;
  Score? score;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (fixture != null) {
      map['fixture'] = fixture?.toJson();
    }
    if (league != null) {
      map['league'] = league?.toJson();
    }
    if (teams != null) {
      map['teams'] = teams?.toJson();
    }
    if (goals != null) {
      map['goals'] = goals?.toJson();
    }
    if (score != null) {
      map['score'] = score?.toJson();
    }
    return map;
  }

}