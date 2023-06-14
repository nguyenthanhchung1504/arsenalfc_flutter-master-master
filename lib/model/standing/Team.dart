class Team {
  Team({
      this.id, 
      this.name, 
      this.logo,});

  Team.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  int? id;
  String? name;
  String? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    return map;
  }

}