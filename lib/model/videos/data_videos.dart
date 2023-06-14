class DataVideo {
  DataVideo({
      this.id, 
      this.title, 
      this.createdDate, 
      this.thumbnail, 
      this.views, 
      this.uploadDate, 
      this.tags, 
      this.youtubeLink, 
      this.videoLink, 
      this.videoInfo, 
      this.uploader,});

  DataVideo.fromJson(dynamic json) {
    id = json['ID'];
    title = json['Title'];
    createdDate = json['CreatedDate'];
    thumbnail = json['Thumbnail'];
    views = json['Views'];
    uploadDate = json['UploadDate'];
    tags = json['Tags'];
    youtubeLink = json['YoutubeLink'];
    videoLink = json['VideoLink'];
    videoInfo = json['VideoInfo'];
    uploader = json['Uploader'];
  }
  int? id;
  String? title;
  String? createdDate;
  String? thumbnail;
  int? views;
  String? uploadDate;
  dynamic tags;
  String? youtubeLink;
  String? videoLink;
  String? videoInfo;
  dynamic uploader;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Title'] = title;
    map['CreatedDate'] = createdDate;
    map['Thumbnail'] = thumbnail;
    map['Views'] = views;
    map['UploadDate'] = uploadDate;
    map['Tags'] = tags;
    map['YoutubeLink'] = youtubeLink;
    map['VideoLink'] = videoLink;
    map['VideoInfo'] = videoInfo;
    map['Uploader'] = uploader;
    return map;
  }

}