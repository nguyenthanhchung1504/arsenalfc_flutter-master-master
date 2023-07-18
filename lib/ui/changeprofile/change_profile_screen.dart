import 'package:arsenalfc_flutter/ui/changeprofile/change_profile_controller.dart';
import 'package:arsenalfc_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChangeProfileScreen extends GetView<ChangeProfileController>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor : Colors.white,
          title: const Text(
            "Thiết lập thông tin cá nhân",
            style: TextStyle(
                fontFamily: "montserrat_black",
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black),
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onTap: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    controller.getFromGallery();
                  },
                  child: Container(
                    height: 85,
                    width: 85,
                    margin: const EdgeInsets.only(top: 24),
                    child:   Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(() => ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48), // Image radius
                            child: Image.network(controller.linkAvatar.value.isNotEmpty == true ? controller.linkAvatar.value
                                : 'https://www.w3schools.com/w3images/avatar2.png', fit: BoxFit.cover),
                          ),
                        ),),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 24,height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(AppColors.RED),
                            ),
                            child: const Icon(Icons.camera_alt,color: Colors.white,size: 16,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: const Text("Họ và tên",style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: "montserrat_black",),)
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:  TextFormField(
                  readOnly: true,
                  controller: controller.textFullName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(12),
                        width: 16,
                        height: 16,
                        child: Image.asset("assets/images/ic_profile.png",width: 16,height: 16,),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "____ ___ ___",
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
                  style: const TextStyle(fontSize: 15,color: Colors.black, fontFamily: "montserrat_black",fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 8,),

              Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: const Text("Số điện thoại",style: TextStyle(color: Colors.grey, fontSize: 12),)
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:  TextFormField(
                  readOnly: true,
                  controller: controller.textPhone,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(12),
                        width: 16,
                        height: 16,
                        child: Image.asset("assets/images/ic_smartphone.png",width: 16,height: 16,),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "____ ___ ___",
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
                  style: const TextStyle(fontSize: 15,color: Colors.black, fontFamily: "montserrat_black",fontWeight: FontWeight.w500),
                ),
              ),


              const SizedBox(height: 8,),

              Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: const Text("Email",style: TextStyle(color: Colors.grey, fontSize: 12),)
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:  TextFormField(
                  readOnly: true,
                  controller: controller.textMail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(12),
                        width: 16,
                        height: 16,
                        child: Image.asset("assets/images/ic_email_user.png",width: 16,height: 16,),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "____ ___ ___",
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey,width: 0.5),
                      ),
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
                  style: const TextStyle(fontSize: 15,color: Colors.black, fontFamily: "montserrat_black",fontWeight: FontWeight.w500),
                ),
              ),
              
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 16),
                child: const Text("Chúng tôi đảm bảo về bảo mật thông tin và quyền riêng tư thông tin cá .",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: "montserrat_black",fontWeight: FontWeight.w500),),
              ),

              GestureDetector(
                onTap: (){
                  Fluttertoast.showToast(
                      msg: "Tính năng đang phát triển.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(AppColors.RED),
                      textColor: Colors.white,
                      fontSize: 14.0
                  );
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color(AppColors.RED),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Text("Lưu",textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600, fontFamily: "montserrat_black" ),),
                ),
              )
            ],
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }

}