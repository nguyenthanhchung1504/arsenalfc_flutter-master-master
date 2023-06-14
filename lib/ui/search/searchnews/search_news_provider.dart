import 'package:get/get.dart';

import '../../../model/news/news_response.dart';

class SearchNewsProviders extends GetConnect{
  var header = {
    "Content-Type" : "application/json"
  };

  Future<Response<NewsResponse>> getNews(body) => post("https://api.afcvn.website/api/news/GetNews",body,headers: header,decoder: (obj) => NewsResponse.fromJson(obj));
}