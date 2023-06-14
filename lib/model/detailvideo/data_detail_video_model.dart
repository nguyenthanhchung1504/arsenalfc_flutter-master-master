class DataDetailVideoModel {
  DataDetailVideoModel({
      this.id, 
      this.videoLink, 
      this.videoInfo, 
      this.views, 
      this.uploadDate, 
      this.uploader, 
      this.thumbnail, 
      this.tags, 
      this.title, 
      this.youtubeLink,});

  DataDetailVideoModel.fromJson(dynamic json) {
    id = json['ID'];
    videoLink = json['VideoLink'];
    videoInfo = json['VideoInfo'];
    views = json['Views'];
    uploadDate = json['UploadDate'];
    uploader = json['Uploader'];
    thumbnail = json['Thumbnail'];
    tags = json['Tags'];
    title = json['Title'];
    youtubeLink = json['YoutubeLink'];
  }
  int? id;
  String? videoLink;
  String? videoInfo;
  int? views;
  String? uploadDate;
  dynamic uploader;
  String? thumbnail;
  dynamic tags;
  String? title;
  String? youtubeLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['VideoLink'] = videoLink;
    map['VideoInfo'] = videoInfo;
    map['Views'] = views;
    map['UploadDate'] = uploadDate;
    map['Uploader'] = uploader;
    map['Thumbnail'] = thumbnail;
    map['Tags'] = tags;
    map['Title'] = title;
    map['YoutubeLink'] = youtubeLink;
    return map;
  }

}