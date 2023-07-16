
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../model/detailvideo/detail_video_response.dart';
import '../../../../model/videos/video_response.dart';
import '../../api/Api.dart';


class DetailVideoProvider extends GetConnect{

  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<DetailVideoResponse?> getDetailVideo(String id) async{
    final response = await Api.dio.get("/video/$id");
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return DetailVideoResponse.fromJson(parsed);
    }else{
      return null;
    }
  }


  Future<VideoResponse?> getVideos() async{
    var body =  {"PageIndex": "1", "PageSize": "20", "SearchValue": ""};
    final response = await Api.dio.post("/video/GetVideos",data: body);
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return VideoResponse.fromJson(parsed);
    }else{
      return null;
    }
  }
}