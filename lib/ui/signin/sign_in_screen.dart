import 'package:arsenalfc_flutter/ui/signin/sign_in_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignInScreen extends GetView<SignInController>{
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_background_sign_in.png"),
              fit: BoxFit.fill,
              opacity: 0.5
            ),
            gradient: LinearGradient(
                colors: [
                  Color(0xFFD7291D),
                  Color(0xFFAA2218),
                ]
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/ic_logo_sign_in.png",width: 140,height: 140,),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    "Official Arsenal Fan Club in Vietnam".toUpperCase(),
                    style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700,),
                      textAlign: TextAlign.center,
                  ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40,bottom: 30),
                child: const Text("Tham gia ngay cùng các Gooners",
                  style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500,))
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    print("onChanged  ${value.isEmpty ? true : false}");
                  },
                  decoration: const InputDecoration(
                      filled: true,
                    fillColor: Colors.white,
                      hintText: "Username",
                      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 14)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: TextField(
                  onChanged: (value) {
                    print("onChanged  ${value.isEmpty ? true : false}");
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 14)),
                ),
              ),

              GestureDetector(
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: Get.width,
                    height: 48,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.grey
                          ]
                      ),
                      borderRadius:  BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: const Text("Đăng nhập",style: TextStyle(fontSize: 14,color: Colors.white),
                      textAlign: TextAlign.center,)
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 24,bottom: 70),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bạn chưa có tài khoản ? ",style: TextStyle(fontSize: 14,color: Colors.white70),
                      textAlign: TextAlign.center,),
                    Text(" Đăng ký ngay",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
