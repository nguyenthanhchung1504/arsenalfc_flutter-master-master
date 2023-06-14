class VideoInfo {
  VideoInfo({
      this.uri,});

  VideoInfo.fromJson(dynamic json) {
    uri = json['uri'];
  }
  String? uri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uri'] = uri;
    return map;
  }

}