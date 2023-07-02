import 'dart:convert';

import 'package:arsenalfc_flutter/model/news/news_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../api/Api.dart';

class NewsProvider extends GetConnect{


  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }


  Future<NewsResponse?> getNews(int pageIndex) async{
    var body =  {"PageIndex": "$pageIndex", "PageSize": pageIndex == 1 ? "21" : Api.PAGE_SIZE, "SearchValue": ""};
    final response = await Api.dio.post("/news/GetNews",data: body);
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return NewsResponse.fromJson(parsed);
    }else{
      return null;
    }
  }
}