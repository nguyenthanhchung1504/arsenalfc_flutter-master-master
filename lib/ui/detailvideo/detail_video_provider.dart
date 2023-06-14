
import 'package:get/get.dart';

import '../../../../model/detailvideo/detail_video_response.dart';
import '../../../../model/videos/video_response.dart';



class DetailVideoProvider extends GetConnect{
  var header = {
    "Content-Type" : "application/json"
  };

  Future<Response<DetailVideoResponse>> getDetailVideo(String id) => get("https://api.afcvn.website/api/video/$id",headers: header,decoder: (obj) => DetailVideoResponse.fromJson(obj));
  Future<Response<VideoResponse>> getVideos(body) => post("https://api.afcvn.website/api/video/GetVideos",body,headers: header,decoder: (obj) => VideoResponse.fromJson(obj));
}