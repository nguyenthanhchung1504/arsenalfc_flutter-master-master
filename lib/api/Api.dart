import 'package:dio/dio.dart';

class Api {
  static var uri = "https://api.afcvn.website/api";
  static int PAGE_SIZE = 20;
  static BaseOptions options = BaseOptions(
      baseUrl: uri,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Accept": "application/json",
      });

  static Dio dio = Dio(options);




}
