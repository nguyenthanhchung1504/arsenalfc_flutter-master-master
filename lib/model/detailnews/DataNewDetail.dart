class DataNewDetail {
  DataNewDetail({
      this.id, 
      this.title, 
      this.content, 
      this.videoLink, 
      this.videoID, 
      this.createdBy, 
      this.createdDate, 
      this.modifiedDate, 
      this.thumbnail, 
      this.views, 
      this.videoTitle, 
      this.videoThumbnail, 
      this.videoInfo, 
      this.modifiedBy,});

  DataNewDetail.fromJson(dynamic json) {
    id = json['ID'];
    title = json['Title'];
    content = json['Content'];
    videoLink = json['VideoLink'];
    videoID = json['VideoID'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    thumbnail = json['Thumbnail'];
    views = json['Views'];
    videoTitle = json['VideoTitle'];
    videoThumbnail = json['VideoThumbnail'];
    videoInfo = json['VideoInfo'];
    modifiedBy = json['ModifiedBy'];
  }
  int? id;
  String? title;
  String? content;
  dynamic videoLink;
  dynamic videoID;
  String? createdBy;
  String? createdDate;
  dynamic modifiedDate;
  String? thumbnail;
  int? views;
  dynamic videoTitle;
  dynamic videoThumbnail;
  dynamic videoInfo;
  dynamic modifiedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Title'] = title;
    map['Content'] = content;
    map['VideoLink'] = videoLink;
    map['VideoID'] = videoID;
    map['CreatedBy'] = createdBy;
    map['CreatedDate'] = createdDate;
    map['ModifiedDate'] = modifiedDate;
    map['Thumbnail'] = thumbnail;
    map['Views'] = views;
    map['VideoTitle'] = videoTitle;
    map['VideoThumbnail'] = videoThumbnail;
    map['VideoInfo'] = videoInfo;
    map['ModifiedBy'] = modifiedBy;
    return map;
  }

}