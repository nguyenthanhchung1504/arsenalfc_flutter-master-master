import 'package:arsenalfc_flutter/ui/signin/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignInController extends GetxController {
  final SignInProviders providers;

  SignInController({required this.providers});

  TextEditingController textUser = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  @override
  void onInit() {

  }

  void actionLogin(){
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

  }
}