import 'dart:io';
import 'dart:ui';

import 'package:arsenalfc_flutter/routes/routes.dart';
import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/home/home_screen.dart';
import 'package:arsenalfc_flutter/ui/signin/sign_in_screen.dart';
import 'package:arsenalfc_flutter/ui/splash/splash_screen.dart';
import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  print("Vừa có một bài viết mới: ${message.data['title'].toString()}");
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // bool isConnected = await InternetConnectionChecker().hasConnection;
  bool isConnected = true;
  if(isConnected) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    if(kReleaseMode) {
      FlutterError.onError = (errorDetails) {
        // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    if(Platform.isAndroid) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }else{
      NotificationPermissions.requestNotificationPermissions(
          iosSettings: const NotificationSettingsIos(
              sound: true, badge: true, alert: true))
          .then((_) {
        // when finished, check the permission status
      });
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    MobileAds.instance.initialize();
  }
  // PermissionStatus status =
  //     await NotificationPermissions.getNotificationPermissionStatus();

  // NotificationPermissions.requestNotificationPermissions(
  //         iosSettings: const NotificationSettingsIos(
  //             sound: true, badge: true, alert: true))
  //     .then((_) {
  //   // when finished, check the permission status
  // });


  runApp(GetMaterialApp(
    translations: Messages(),
    locale: const Locale('vi', 'VI'),
    fallbackLocale: const Locale('us', 'US'),
    initialRoute: AppConst.MAIN,
    getPages: routes(),
  ));
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SplashScreen();
        // return const SignInScreen();
      },
    );
  }
}
