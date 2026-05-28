import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../core/error/failure.dart';
import '../../core/error/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final fb.FirebaseAuth _auth;

  @override
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map(_mapUser);
  }

  @override
  AppUser? get currentUser => _mapUser(_auth.currentUser);

  @override
  Future<Result<AppUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return guard(() async {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return _requireUser(cred.user);
    }, onError: _mapAuthError);
  }

  @override
  Future<Result<AppUser>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return guard(() async {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await cred.user?.updateDisplayName(displayName.trim());
      return _requireUser(_auth.currentUser);
    }, onError: _mapAuthError);
  }

  @override
  Future<Result<AppUser>> signInWithGoogle() async =>
      const Err(NotImplementedFailure('Google Sign-In sẽ bật ở bản sau.'));

  @override
  Future<Result<AppUser>> signInWithApple() async =>
      const Err(NotImplementedFailure('Apple Sign-In sẽ bật ở bản sau.'));

  @override
  Future<Result<AppUser>> signInAnonymously() async {
    return guard(() async {
      final cred = await _auth.signInAnonymously();
      return _requireUser(cred.user);
    }, onError: _mapAuthError);
  }

  @override
  Future<Result<void>> signOut() async {
    return guard(() async {
      await _auth.signOut();
    }, onError: _mapAuthError);
  }

  @override
  Future<Result<void>> sendPasswordReset(String email) async {
    return guard(() async {
      await _auth.sendPasswordResetEmail(email: email.trim());
    }, onError: _mapAuthError);
  }

  @override
  Future<Result<AppUser>> updateProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    return guard(() async {
      final user = _auth.currentUser;
      if (user == null) throw const AuthFailure();
      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }
      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
      }
      await user.reload();
      return _requireUser(_auth.currentUser);
    }, onError: _mapAuthError);
  }

  AppUser _requireUser(fb.User? user) {
    final mapped = _mapUser(user);
    if (mapped == null) throw const AuthFailure();
    return mapped;
  }

  AppUser? _mapUser(fb.User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
      isAnonymous: user.isAnonymous,
    );
  }

  Failure _mapAuthError(Object error, StackTrace stack) {
    if (error is Failure) return error;
    if (error is fb.FirebaseAuthException) {
      return AuthFailure(
        message: _authMessage(error.code),
        cause: error,
        stackTrace: stack,
      );
    }
    return UnknownFailure(cause: error, stackTrace: stack);
  }

  String _authMessage(String code) {
    return switch (code) {
      'user-not-found' => 'Tài khoản không tồn tại.',
      'wrong-password' => 'Mật khẩu không đúng.',
      'email-already-in-use' => 'Email đã được đăng ký.',
      'invalid-email' => 'Email không hợp lệ.',
      'weak-password' => 'Mật khẩu quá yếu (tối thiểu 6 ký tự).',
      'user-disabled' => 'Tài khoản đã bị vô hiệu hoá.',
      _ => 'Đăng nhập thất bại. Vui lòng thử lại.',
    };
  }
}
