class Home {
  Home({
      this.id, 
      this.name, 
      this.logo, 
      this.winner,});

  Home.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    winner = json['winner'];
  }
  int? id;
  String? name;
  String? logo;
  dynamic winner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    map['winner'] = winner;
    return map;
  }

}