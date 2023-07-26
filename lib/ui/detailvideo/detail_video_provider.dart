
import 'dart:convert';

import 'package:arsenalfc_flutter/model/recomment/video/recommend_video_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../model/detailvideo/detail_video_response.dart';
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


  Future<RecommendVideoResponse?> getVideos(String id) async{
    final response = await Api.dio.get("/video/GetVideoByIDWithRecommendation/$id");
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return RecommendVideoResponse.fromJson(parsed);
    }else{
      return null;
    }
  }
}