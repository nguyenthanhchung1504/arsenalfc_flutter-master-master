import 'package:get/get.dart';

import '../../../model/news/news_response.dart';

class SearchVideoProviders extends GetConnect{
  var header = {
    "Content-Type" : "application/json"
  };

  Future<Response<NewsResponse>> getVideos(body) => post("https://api.afcvn.website/api/video/GetVideos",body,headers: header,decoder: (obj) => NewsResponse.fromJson(obj));
}