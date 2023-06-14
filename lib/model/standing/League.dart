import 'Standings.dart';

class League {
  League({
      this.id, 
      this.name, 
      this.country, 
      this.logo, 
      this.flag, 
      this.season, 
      this.standings,});

  League.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
    season = json['season'];
    if (json['standings'] != null) {
      standings = [];
      json['standings'].forEach((v) {
        standings?.add(v);
      });
    }
  }
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  List<dynamic>? standings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country'] = country;
    map['logo'] = logo;
    map['flag'] = flag;
    map['season'] = season;
    if (standings != null) {
      map['standings'] = standings?.map((v) => v).toList();
    }
    return map;
  }

}