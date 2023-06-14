import 'package:arsenalfc_flutter/model/news/news_response.dart';
import 'package:get/get.dart';

class NewsProvider extends GetConnect{

  var header = {
    "Content-Type" : "application/json"
  };

  Future<Response<NewsResponse>> getNews(body) => post("https://api.afcvn.website/api/news/GetNews",body,headers: header,decoder: (obj) => NewsResponse.fromJson(obj));
}