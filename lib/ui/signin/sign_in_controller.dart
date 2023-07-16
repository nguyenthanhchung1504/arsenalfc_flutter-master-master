import 'package:arsenalfc_flutter/ui/signin/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../model/login/LoginResponse.dart';
import '../../routes/routes_const.dart';
import '../../utils/colors.dart';
import '../../utils/status.dart';

class SignInController extends GetxController {
  final SignInProviders providers;

  SignInController({required this.providers});

  TextEditingController textUser = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  final storage = GetStorage();



  void actionLogin() async{
    if(textUser.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Bạn chưa nhập username",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
      return;
    }
    if(textPassword.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Bạn chưa nhập password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
      return;
    }

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if(isConnected) {
      EasyLoading.show(status: 'loading...');
      LoginResponse? response = await providers.login(
          textUser.text, textPassword.text);
      if (response?.resultCode == StatusResponse.Success) {
        storage.write(AppConst.KEY_EMAIL, textUser.text);
        storage.write(AppConst.KEY_PASSWORD, textPassword.text);
        storage.write(AppConst.KEY_PASSWORD, textPassword.text);
        storage.write(AppConst.KEY_PASSWORD, textPassword.text);
        storage.write(AppConst.TOKEN, response?.data?.token ?? "");
        Get.offAndToNamed(AppConst.HOME);
      }else{
        Fluttertoast.showToast(
            msg: "Đã có lỗi xảy ra, xin vui lòng thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(AppColors.RED),
            textColor: Colors.white,
            fontSize: 14.0
        );
      }
    }else{
      Fluttertoast.showToast(
          msg: "Không có kết nối mạng xin vui lòng kiểm tra.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor:  const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    EasyLoading.dismiss();

  }
}