class Parameters {
  Parameters({
      this.date,});

  Parameters.fromJson(dynamic json) {
    date = json['date'];
  }
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    return map;
  }

}