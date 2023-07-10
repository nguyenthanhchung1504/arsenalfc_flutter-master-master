import 'dart:convert';

import 'package:get/get_connect/connect.dart';

import '../../api/Api.dart';
import '../../model/login/LoginResponse.dart';

class SignInProviders extends GetConnect{
  var header = {
    "Content-Type" : "application/json"
  };

  Future<LoginResponse?> login(String username,String password) async{
    var body =  {"UserName": username,"Password" : password};
    final response = await Api.dio.post("/Login/Login",data: body);
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return LoginResponse.fromJson(parsed);
    }else{
      return null;
    }
  }

}