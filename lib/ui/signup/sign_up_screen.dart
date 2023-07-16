import 'package:arsenalfc_flutter/ui/signup/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class SignUpScreen extends GetView<SignUpController>{
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg_background_sign_in.png"),
                    fit: BoxFit.fill,
                    opacity: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 55,),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/ic_logo_sign_in.png",
                      width: 140,
                      height: 140,color:  Color(AppColors.RED),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: Text(
                      "Official Arsenal Fan Club in Vietnam".toUpperCase(),
                      style:  const TextStyle(
                          color:  Color(AppColors.RED),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: "montserrat_black"),
                      textAlign: TextAlign.center,
                    ),
                  ),


                  const Padding(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 20),
                    child: Center(
                      child: Text(
                        "Tham gia ngay cùng các Gooners",
                        style: TextStyle(
                            color: Color(AppColors.RED),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "montserrat_black"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:  TextField(
                      controller: controller.fullName,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Họ và tên",
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16,left: 16,top: 16),
                    child: TextField(
                      controller: controller.email,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                             borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                             borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16,left: 16,top: 16),
                    child: TextField(
                      controller: controller.phone,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Số điện thoại",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey,width: 1.0),
                          ),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: controller.textPassword,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ),


                  GestureDetector(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      controller.actionRegister();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: Get.width,
                        height: 48,
                        decoration: const BoxDecoration(
                          gradient:
                          LinearGradient(colors: [Color(AppColors.RED), Colors.black]),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "montserrat_black",
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 24, bottom: 90),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Bạn đã có tài khoản đăng nhập rồi?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontFamily: "montserrat_black",
                          ),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Text(
                            " Đăng nhập",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(AppColors.RED),
                              fontWeight: FontWeight.bold,
                              fontFamily: "montserrat_black",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }

}