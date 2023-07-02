import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../api/Api.dart';
import '../../../model/videos/video_response.dart';

class SearchVideoProviders extends GetConnect{
  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<VideoResponse?> getVideos(int pageIndex,String search) async{
    var body =  {"PageIndex": "$pageIndex", "PageSize": "20", "SearchValue": search};
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