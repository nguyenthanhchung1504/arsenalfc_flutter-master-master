
import 'package:arsenalfc_flutter/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/routes_const.dart';
import '../home/home_screen.dart';
import '../signin/sign_in_screen.dart';


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final storage = GetStorage();
    Future.delayed(const Duration(seconds: 3), () {

      if(storage.read(AppConst.KEY_EMAIL) != null){
        if(storage.read(AppConst.KEY_EMAIL).toString().isNotEmpty){
          Get.offNamed(AppConst.HOME);
        }else{
          Get.offNamed(AppConst.SIGN_IN);
        }
      }else{
        Get.offNamed(AppConst.SIGN_IN);
      }

    });



  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 300,
                    child: Image.asset("assets/images/ic_logo_arsenal.png"),
                  ),
                )
            ),
            Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(86, 0, 86, 108),
                      child: Text("Official Arsenal Fan Club in Vietnam",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "montserrat_black",
                              color: HexColor.fromHex("#DC2F20"),
                            fontWeight: FontWeight.w700

                          )
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}