import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gooner_vietnam/core/constants/app_info.dart';
import 'package:gooner_vietnam/routes/routes_const.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../../../data/repositories/firebase_auth_repository.dart';
import '../../../../model/user_info/user_data.dart';
import 'more_provider.dart';

class MoreController extends GetxController {
  MoreController({required this.provider});

  final MoreProvider provider;
  final storage = GetStorage();
  final _authRepo = FirebaseAuthRepository(FirebaseAuth.instance);

  Rx<UserData?>? userData = UserData().obs;
  RxString linkAvatar = ''.obs;
  String? token;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    googlePlayIdentifier: AppInfo.androidPackage,
    appStoreIdentifier: AppInfo.iosAppStoreId,
  );

  void getUserInfo() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.offNamed(AppConst.SIGN_IN);
      return;
    }

    token = user.uid;
    storage.write(AppConst.TOKEN, user.uid);
    if (user.email != null) {
      storage.write(AppConst.KEY_EMAIL, user.email);
    }

    userData?.value = UserData(
      fullName: user.displayName ?? storage.read(AppConst.KEY_FULLNAME),
      email: user.email,
      phoneNumber: user.phoneNumber ?? storage.read(AppConst.KEY_PHONE),
      avatarLink: user.photoURL,
    );
    linkAvatar.value = user.photoURL ?? '';
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
    await storage.erase();
    Get.offNamed(AppConst.SIGN_IN);
  }

  void showRate() {
    rateMyApp.showStarRateDialog(
      Get.context!,
      title: 'Đánh giá app',
      message:
          'Bạn thích ứng dụng này? Sau đó, hãy dành một chút thời gian của bạn để xếp hạng',
      actionsBuilder: (context, stars) {
        return [
          TextButton(
            child: const Text('Đồng ý'),
            onPressed: () async {
              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(
                context,
                RateMyAppDialogButton.rate,
              );
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid,
      dialogStyle: const DialogStyle(
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: const StarRatingOptions(),
      onDismissed: () =>
          rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }
}
