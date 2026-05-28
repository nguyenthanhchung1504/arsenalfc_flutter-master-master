import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/providers.dart';
import 'core/services/firebase_service.dart';
import 'core/storage/local_storage.dart';
import 'firebase_options.dart';
import 'routes/routes.dart';
import 'routes/routes_const.dart';
import 'ui/splash/splash_screen.dart';
import 'utils/messages.dart';

/// FCM background handler (top-level — yêu cầu của plugin).
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await flutterLocalNotificationsPlugin.show(
    message.data.hashCode,
    message.data['title']?.toString(),
    message.data['body']?.toString(),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.high,
      ),
    ),
  );
}

const _channelId = 'high_importance_channel';
const _channelName = 'High Importance Notifications';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  _channelId,
  _channelName,
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env', isOptional: true);

  final localStorage = await LocalStorage.init();
  final firebaseService = await FirebaseService.ensureInitialized();

  if (Platform.isAndroid) {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  unawaited(MobileAds.instance.initialize());

  runApp(
    ProviderScope(
      overrides: [
        localStorageProvider.overrideWithValue(localStorage),
        firebaseServiceProvider.overrideWithValue(firebaseService),
      ],
      child: const _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gooner Vietnam',
      translations: Messages(),
      locale: const Locale('vi', 'VN'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppConst.MAIN,
      getPages: routes(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void unawaited(Future<void> future) {}

/// Shell splash — giữ tương thích route `AppConst.MAIN` (GetX).
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
