import 'League.dart';

class Response {
  Response({
      this.league,});

  Response.fromJson(dynamic json) {
    league = json['league'] != null ? League.fromJson(json['league']) : null;
  }
  League? league;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (league != null) {
      map['league'] = league?.toJson();
    }
    return map;
  }

}