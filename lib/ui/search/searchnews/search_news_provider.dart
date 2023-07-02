import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../api/Api.dart';
import '../../../model/news/news_response.dart';

class SearchNewsProviders extends GetConnect{
  var header = {
    "Content-Type" : "application/json"
  };

  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<NewsResponse?> getNews(int pageIndex,String search) async{
    var body =  {"PageIndex": "$pageIndex", "PageSize": "20", "SearchValue": search};
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