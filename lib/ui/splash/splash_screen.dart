import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gooner_vietnam/core/constants/app_info.dart';
import 'package:gooner_vietnam/routes/routes_const.dart';
import 'package:gooner_vietnam/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _routeAfterSplash();
  }

  Future<void> _routeAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser ??
        await FirebaseAuth.instance
            .authStateChanges()
            .first
            .timeout(const Duration(seconds: 5), onTimeout: () => null);

    if (!mounted) return;

    final storage = GetStorage();
    if (user != null) {
      storage.write(AppConst.KEY_EMAIL, user.email ?? '');
      storage.write(AppConst.TOKEN, user.uid);
      if (user.displayName != null && user.displayName!.isNotEmpty) {
        storage.write(AppConst.KEY_FULLNAME, user.displayName);
      }
      Get.offNamed(AppConst.HOME);
    } else {
      Get.offNamed(AppConst.SIGN_IN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 200,
                height: 300,
                child: Image.asset('assets/images/ic_logo_arsenal.png'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(86, 0, 86, 108),
                child: Text(
                  AppInfo.displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'montserrat_black',
                    color: const Color(AppColors.RED_LIGHT),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
