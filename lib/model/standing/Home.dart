import 'Goals.dart';

class Home {
  Home({
      this.played, 
      this.win, 
      this.draw, 
      this.lose, 
      this.goals,});

  Home.fromJson(dynamic json) {
    played = json['played'];
    win = json['win'];
    draw = json['draw'];
    lose = json['lose'];
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
  }
  int? played;
  int? win;
  int? draw;
  int? lose;
  Goals? goals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['played'] = played;
    map['win'] = win;
    map['draw'] = draw;
    map['lose'] = lose;
    if (goals != null) {
      map['goals'] = goals?.toJson();
    }
    return map;
  }

}