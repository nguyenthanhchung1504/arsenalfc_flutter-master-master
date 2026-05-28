import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../domain/entities/app_user.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/news_repository.dart';
import '../domain/repositories/player_repository.dart';
import '../domain/repositories/schedule_repository.dart';
import '../domain/repositories/video_repository.dart';
import 'repositories/firebase_auth_repository.dart';
import 'repositories/firestore_news_repository.dart';
import 'repositories/firestore_video_repository.dart';
import 'repositories/firestore_schedule_repository.dart';
import 'repositories/stub_repositories.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return FirestoreNewsRepository(ref.watch(firestoreProvider));
});

final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  return FirestoreVideoRepository(ref.watch(firestoreProvider));
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return FirestoreScheduleRepository(ref.watch(firestoreProvider));
});

final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return const StubPlayerRepository();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(ref.watch(firebaseAuthProvider));
});

/// Stream user đăng nhập hiện tại.
final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final currentUserProvider = Provider<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).currentUser;
});
