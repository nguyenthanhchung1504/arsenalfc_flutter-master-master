import 'Home.dart';
import 'Away.dart';

class Teams {
  Teams({
      this.home, 
      this.away,});

  Teams.fromJson(dynamic json) {
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Away.fromJson(json['away']) : null;
  }
  Home? home;
  Away? away;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (home != null) {
      map['home'] = home?.toJson();
    }
    if (away != null) {
      map['away'] = away?.toJson();
    }
    return map;
  }

}