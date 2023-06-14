import 'Team.dart';
import 'Home.dart';

class Standings {
  Standings({
      this.rank, 
      this.team, 
      this.points, 
      this.goalsDiff, 
      this.group, 
      this.form, 
      this.status, 
      this.description, 
      this.all, 
      this.home, 
      this.away, 
      this.update,});

  Standings.fromJson(dynamic json) {
    rank = json['rank'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    points = json['points'];
    goalsDiff = json['goalsDiff'];
    group = json['group'];
    form = json['form'];
    status = json['status'];
    description = json['description'];
    all = json['all'] != null ? Home.fromJson(json['all']) : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Home.fromJson(json['away']) : null;
    update = json['update'];
  }
  int? rank;
  Team? team;
  int? points;
  int? goalsDiff;
  String? group;
  String? form;
  String? status;
  String? description;
  Home? all;
  Home? home;
  Home? away;
  String? update;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rank'] = rank;
    if (team != null) {
      map['team'] = team?.toJson();
    }
    map['points'] = points;
    map['goalsDiff'] = goalsDiff;
    map['group'] = group;
    map['form'] = form;
    map['status'] = status;
    map['description'] = description;
    if (all != null) {
      map['all'] = all?.toJson();
    }
    if (home != null) {
      map['home'] = home?.toJson();
    }
    if (away != null) {
      map['away'] = away?.toJson();
    }
    map['update'] = update;
    return map;
  }

}