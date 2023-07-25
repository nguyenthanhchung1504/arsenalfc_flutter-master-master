import 'dart:convert';

import 'package:arsenalfc_flutter/model/detailnews/DetailNewModel.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../api/Api.dart';
import '../../model/recomment/news/recomment_news_response.dart';

class DetailProvider extends GetConnect{

  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }



  Future<DetailNewModel?> getDetailNews(String id) async {
    final response = await Api.dio.get("https://api.afcvn.website/api/news/$id");
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return DetailNewModel.fromJson(parsed);
    }else{
      return null;
    }
  }


  Future<RecommendNewsResponse?> getNewsRecommend(String id) async {
    final response = await Api.dio.get("https://api.afcvn.website/api/news/GetNewsByIDWithRecommendation/$id");
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return RecommendNewsResponse.fromJson(parsed);
    }else{
      return null;
    }
  }
}