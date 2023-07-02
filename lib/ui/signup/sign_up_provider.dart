import 'dart:convert';

import 'package:arsenalfc_flutter/model/login/LoginResponse.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../api/Api.dart';

class SignUpProvider extends GetConnect{
  @override
  void onInit() {
    Api.dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<LoginResponse?> register(String fullName,String email,String phone,String password) async{
    var body =  {"UserName": email, "FullName": fullName, "Email": email,"PhoneNumber" : phone,"Password" : password};
    final response = await Api.dio.post("/Login/MobileSignUp",data: body);
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return LoginResponse.fromJson(parsed);
    }else{
      return null;
    }
  }
}