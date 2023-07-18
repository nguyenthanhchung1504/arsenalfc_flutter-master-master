import 'package:arsenalfc_flutter/ui/signin/sign_in_controller.dart';
import 'package:arsenalfc_flutter/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../routes/routes_const.dart';

class SignInScreen extends GetView<SignInController> {


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
                gradient: LinearGradient(
                    colors: [
                        Color(0xFFD7291D),
                        Color(0xFFAA2218),

                    ]
                ),
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
                      height: 140,color: Colors.white,
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: Text(
                      "Official Arsenal Fan Club in Vietnam".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
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
                        "Chào mừng bạn quay trở lại !,",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "montserrat_black"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: controller.textUser,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.white,width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.white,width: 2.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.white,width: 2.0),
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
                      Fluttertoast.showToast(
                          msg: "Tính năng đang phát triển.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor:  Colors.white,
                          textColor: Colors.black,
                          fontSize: 14.0
                      );
                    },
                    child:  Container(
                      padding: const EdgeInsets.only(right: 16,bottom: 12),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Bạn quên mật khẩu?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "montserrat_black",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),


                  GestureDetector(
                    onTap: (){
                      controller.actionLogin();
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: Get.width,
                        height: 48,
                        decoration: const BoxDecoration(
                          gradient:
                              LinearGradient(colors: [Colors.white, Colors.grey]),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(AppColors.RED),
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
                          "Bạn chưa có tài khoản ? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: "montserrat_black",
                          ),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppConst.SIGN_UP);
                          },
                          child: const Text(
                            " Đăng ký ngay",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
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
