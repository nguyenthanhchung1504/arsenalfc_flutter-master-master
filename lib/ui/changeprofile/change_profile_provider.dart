

import 'dart:convert';
import 'dart:io';

import 'package:arsenalfc_flutter/model/upload/upload_avatar_response.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../../api/Api.dart';
import '../../routes/routes_const.dart';

class ChangeProfileProvider extends GetConnect{
  final storage = GetStorage();

  @override
  void onInit() {
    Api.dio.interceptors.add(_dio.LogInterceptor(responseBody: true));
  }

  Future<UploadAvatarResponse?> postImage(File? file) async{
    String? token =  storage.read(AppConst.TOKEN);


    final formData = _dio.FormData.fromMap({
      "file": await _dio.MultipartFile.fromFile(
        file?.path ?? "",
        filename: "${const Uuid().v4()}.png",
      ),
    });

    final response = await Api.dio.post("/user/ChangeUserAvatar",data: formData,options: _dio.Options(
        headers: {
          "Accept": "application/json",
          "Authorization" : token
        }
    ));
    if(response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(
          jsonEncode(response.data));
      return UploadAvatarResponse.fromJson(parsed);
    }else{
      return null;
    }
  }
}