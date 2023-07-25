import 'package:arsenalfc_flutter/model/login/LoginResponse.dart';
import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/signup/sign_up_provider.dart';
import 'package:arsenalfc_flutter/utils/colors.dart';
import 'package:arsenalfc_flutter/utils/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../model/login/RegisterResponse.dart';

class SignUpController extends GetxController{
  final SignUpProvider provider;
  final storage = GetStorage();
  SignUpController({required this.provider});

  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  bool validateEmail(){
    bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text);
    if(emailValid){
      return true;
    }else{
      Fluttertoast.showToast(
          msg: "Email không đúng định dạng",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
      return false;
    }
  }

  void actionRegister() async{
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if(isConnected) {
      if (validateRegister()) {
        if (validateEmail()) {
          EasyLoading.show(status: 'loading...');
          RegisterResponse? response = await provider.register(
              fullName.text, email.text, phone.text, textPassword.text);
          if (response?.resultCode == StatusResponse.Duplicate) {
            Fluttertoast.showToast(
                msg: "Email đã tồn tại",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: const Color(AppColors.RED),
                textColor: Colors.white,
                fontSize: 14.0
            );
          } else if (response?.resultCode == StatusResponse.Success) {
            storage.write(AppConst.KEY_EMAIL, email.text);
            storage.write(AppConst.KEY_FULLNAME, fullName.text);
            storage.write(AppConst.KEY_PHONE, phone.text);
            storage.write(AppConst.KEY_PASSWORD, textPassword.text);
            Get.toNamed(AppConst.HOME);
          } else {
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
        }
      }
    }else{
      Fluttertoast.showToast(
          msg: "Không có kết nối mạng xin vui lòng kiểm tra.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    EasyLoading.dismiss();
  }


  bool validateRegister(){
    if(fullName.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Bạn chưa nhập Họ và tên",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
      return false;
    }

    if(email.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Bạn chưa nhập Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
      return false;
    }

    if(textPassword.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Bạn chưa nhập Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
      return false;
    }
    return true;
  }


}


