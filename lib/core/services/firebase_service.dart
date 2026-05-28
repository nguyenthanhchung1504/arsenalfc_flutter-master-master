import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

/// Trạng thái khởi tạo Firebase. Cho phép Riverpod chờ async init.
class FirebaseService {
  FirebaseService._(this.app);

  final FirebaseApp app;

  static FirebaseService? _instance;
  static FirebaseService? get instance => _instance;

  static Future<FirebaseService> ensureInitialized() async {
    if (_instance != null) return _instance!;
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kReleaseMode) {
      FlutterError.onError = (details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    _instance = FirebaseService._(app);
    return _instance!;
  }
}
