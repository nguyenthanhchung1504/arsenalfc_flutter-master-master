class Goals {
  Goals({
      this.against,});

  Goals.fromJson(dynamic json) {
    against = json['against'];
  }

  int? against;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['against'] = against;
    return map;
  }

}