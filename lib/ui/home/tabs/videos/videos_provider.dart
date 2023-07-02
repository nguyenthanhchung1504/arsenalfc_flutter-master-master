
import 'dart:convert';

import 'package:arsenalfc_flutter/api/Api.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/connect.dart';

import '../../../../model/videos/video_response.dart';



class VideosProvider extends GetConnect{

  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }


  Future<VideoResponse?> getVideos(int pageIndex) async{
    var body =  {"PageIndex": "$pageIndex", "PageSize": "20", "SearchValue": ""};
    final response = await Api.dio.post("/video/GetVideos",data: body);
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return VideoResponse.fromJson(parsed);
    }else{
      return null;
    }
  }

  Future<VideoResponse?> getVideosHeader(int pageIndex) async{
    var body =  {"PageIndex": "$pageIndex", "PageSize": "5", "SearchValue": ""};
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