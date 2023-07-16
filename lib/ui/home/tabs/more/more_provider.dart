import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../api/Api.dart';
import '../../../../model/user_info/user_info_response.dart';

class MoreProvider extends GetConnect{

  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<UserInfoResponse?> getUserInfo(String token) async{

    final response = await Api.dio.get("/user/GetCurrentUserInfo",options: Options(
      headers: {
        "Accept": "application/json",
        "Authorization" : token
      }
    ));
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return UserInfoResponse.fromJson(parsed);
    }else{
      return null;
    }
  }


}