import 'dart:io';

import 'package:arsenalfc_flutter/model/upload/upload_avatar_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/login/LoginResponse.dart';
import '../../model/user_info/user_data.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import 'change_profile_provider.dart';

class ChangeProfileController extends GetxController{
  ChangeProfileProvider provider;

  ChangeProfileController({required this.provider});
  Rx<UserData?>? userData = UserData().obs;
  TextEditingController textFullName = TextEditingController();
  TextEditingController textPhone = TextEditingController();
  TextEditingController textMail = TextEditingController();

  RxString linkAvatar = "".obs;
  RxString linkFile = "".obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var argument = Get.arguments;
    if(argument is UserData){
      userData?.value = argument;
      textFullName.text = userData?.value?.fullName ?? "";
      textPhone.text = userData?.value?.phoneNumber ?? "";
      textMail.text = userData?.value?.email ?? "";
      linkAvatar.value = userData?.value?.avatarLink ?? "";
      update();
    }


  }

  void checkPermission(BuildContext? context) async {
    if(context != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted &&
        statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      getFromGallery();
      //_openDialog(context);
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
      // _showSettingsDialog(context);
    }
  }

   getFromGallery() async{
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if(image?.path != null) {
      File imageFile = File(image?.path ?? "");
      linkFile.value = image?.path ?? "";
      EasyLoading.show();
      postImage(imageFile);
    }
  }

  void postImage(File file) async{
    UploadAvatarResponse? response = await provider.postImage(file);
    if (response?.data != null) {
      linkAvatar.value = response?.data ?? "";
      print( response?.data ?? "");
    }
    update();
    EasyLoading.dismiss();
  }

  void updateUser() async{
    if(textMail.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Email không được để trống!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
      return;
    }

    if(textFullName.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Họ tên không được để trống!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(AppColors.RED),
          textColor: Colors.white,
          fontSize: 14.0
      );
      return;
    }


    EasyLoading.show();

    await provider.updateUser(UserData(fullName: textFullName.text,email: textMail.text,phoneNumber: textPhone.text));
    EasyLoading.dismiss();

  }
}