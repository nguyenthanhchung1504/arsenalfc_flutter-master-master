
import '../../videos/data_videos.dart';

class DataRecommendVideo {
  DataRecommendVideo({
    this.currentVideo,
    this.recommendVideo,});

  DataRecommendVideo.fromJson(dynamic json) {
    currentVideo = json['CurrentVideo'];
    if (json['RecommendVideo'] != null) {
      recommendVideo = [];
      json['RecommendVideo'].forEach((v) {
        recommendVideo?.add(DataVideo.fromJson(v));
      });
    }
  }
  dynamic currentVideo;
  List<DataVideo>? recommendVideo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CurrentVideo'] = currentVideo;
    if (recommendVideo != null) {
      map['RecommendVideo'] = recommendVideo?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}