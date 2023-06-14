
import 'package:get/get_connect/connect.dart';

import '../../../../model/videos/video_response.dart';



class VideosProvider extends GetConnect{

  var header = {
    "Content-Type" : "application/json"
  };

  Future<Response<VideoResponse>> getVideos(body) => post("https://api.afcvn.website/api/video/GetVideos",body,headers: header,decoder: (obj) => VideoResponse.fromJson(obj));
}