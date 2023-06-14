import 'package:arsenalfc_flutter/model/detailnews/DetailNewModel.dart';
import 'package:get/get.dart';

class DetailProvider extends GetConnect{
  Future<Response<DetailNewModel>> getDetailNews(String id) => get("https://api.afcvn.website/api/news/$id",decoder: (obj) => DetailNewModel.fromJson(obj));
}