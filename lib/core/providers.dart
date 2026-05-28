import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/env.dart';
import 'network/dio_client.dart';
import 'services/firebase_service.dart';
import 'storage/local_storage.dart';

/// Khởi tạo trước trong `main()` rồi `override` provider này:
/// ```
/// final storage = await LocalStorage.init();
/// runApp(ProviderScope(overrides: [
///   localStorageProvider.overrideWithValue(storage),
/// ], child: const App()));
/// ```
final localStorageProvider = Provider<LocalStorage>((ref) {
  throw UnimplementedError('Override `localStorageProvider` in main().');
});

/// Firebase được init bất đồng bộ ở `main()`; override sau khi xong.
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  throw UnimplementedError('Override `firebaseServiceProvider` in main().');
});

/// Dio cho api-football (debug only — production đọc Firestore cache).
final footballDioProvider = Provider<Dio>((ref) {
  return createDio(
    baseUrl: Env.footballBaseUrl,
    headers: Env.footballHeaders,
  );
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
