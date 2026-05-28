import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/network/network_info.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../routes/routes_const.dart';
import '../../utils/colors.dart';

class SignInController extends GetxController {
  SignInController();

  final _authRepo = FirebaseAuthRepository(FirebaseAuth.instance);
  final storage = GetStorage();

  final textUser = TextEditingController();
  final textPassword = TextEditingController();

  Future<void> actionLogin() async {
    if (textUser.text.isEmpty) {
      _toast('Bạn chưa nhập email');
      return;
    }
    if (textPassword.text.isEmpty) {
      _toast('Bạn chưa nhập mật khẩu');
      return;
    }

    if (!await NetworkInfo.hasConnection) {
      _toast('Không có kết nối mạng, vui lòng kiểm tra.', isError: true);
      return;
    }

    EasyLoading.show(status: 'loading...');
    final result = await _authRepo.signInWithEmail(
      email: textUser.text.trim(),
      password: textPassword.text,
    );
    EasyLoading.dismiss();

    result.fold(
      (user) {
        storage.write(AppConst.KEY_EMAIL, user.email ?? textUser.text);
        storage.write(AppConst.TOKEN, user.uid);
        Get.offAndToNamed(AppConst.HOME);
      },
      (failure) => _toast(failure.message, isError: true),
    );
  }

  void _toast(String msg, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: isError ? const Color(AppColors.RED) : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: isError ? 14 : 16,
    );
  }
}
