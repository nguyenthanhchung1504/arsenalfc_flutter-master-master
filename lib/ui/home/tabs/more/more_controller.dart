

import 'dart:io';

import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../../../model/user_info/user_data.dart';
import '../../../../model/user_info/user_info_response.dart';
import 'more_provider.dart';

class MoreController extends GetxController{
  MoreProvider provider;

  MoreController({required this.provider});
  final storage = GetStorage();

  Rx<UserData?>? userData = UserData().obs;

  RxString linkAvatar = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserInfo();
  }



  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    googlePlayIdentifier: 'com.ntchung.arsenalafc',
    appStoreIdentifier: 'com.ntchung.arsenalafc',
  );


  void getUserInfo() async{
    String? token =  storage.read(AppConst.TOKEN);

    UserInfoResponse? response = await provider.getUserInfo(token ?? "");
    if(response == null){
      Get.offNamed(AppConst.SIGN_IN);
    }else{
      if(response.resultCode == 401){
        Get.offNamed(AppConst.SIGN_IN);
      }else{
        userData?.value = response.userData;
        linkAvatar.value = response.userData?.avatarLink ?? "";
        update();
      }

    }


  }

  void showRate(){
    rateMyApp.showStarRateDialog(
      Get.context!,
      title: 'Đánh giá app', // The dialog title.
      message: 'Bạn thích ứng dụng này? Sau đó, hãy dành một chút thời gian của bạn để xếp hạng', // The dialog message.
      // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
      actionsBuilder: (context, stars) { // Triggered when the user updates the star rating.
        return [ // Return a list of actions (that will be shown at the bottom of the dialog).
          TextButton(
            child: const Text('Đồng ý'),
            onPressed: () async {
              print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
              // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
              // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
      dialogStyle: const DialogStyle( // Custom dialog styles.
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: const StarRatingOptions(), // Custom star bar rating options.
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
    );
  }
}