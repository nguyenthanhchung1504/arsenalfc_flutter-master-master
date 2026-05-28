import 'package:firebase_auth/firebase_auth.dart';
import 'package:gooner_vietnam/routes/routes_const.dart';
import 'package:gooner_vietnam/utils/colors.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/network/network_info.dart';
import '../../model/login/RegisterResponse.dart';

class SignUpController extends GetxController {
  final _authRepo = FirebaseAuthRepository(FirebaseAuth.instance);
  final storage = GetStorage();

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
    final isConnected = await NetworkInfo.hasConnection;
    if(isConnected) {
      if (validateRegister()) {
        if (validateEmail()) {
          EasyLoading.show(status: 'loading...');
          final result = await _authRepo.signUpWithEmail(
            email: email.text.trim(),
            password: textPassword.text,
            displayName: fullName.text.trim(),
          );
          EasyLoading.dismiss();
          result.fold(
            (user) {
              storage.write(AppConst.KEY_EMAIL, user.email ?? email.text);
              storage.write(AppConst.KEY_FULLNAME, fullName.text);
              storage.write(AppConst.KEY_PHONE, phone.text);
              storage.write(AppConst.TOKEN, user.uid);
              Get.offAndToNamed(AppConst.HOME);
            },
            (failure) {
              Fluttertoast.showToast(
                msg: failure.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: const Color(AppColors.RED),
                textColor: Colors.white,
                fontSize: 14.0,
              );
            },
          );
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


