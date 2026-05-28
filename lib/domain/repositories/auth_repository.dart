import '../../core/error/result.dart';
import '../entities/app_user.dart';

abstract interface class AuthRepository {
  /// Phát mỗi khi auth state thay đổi (null = chưa đăng nhập).
  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;

  Future<Result<AppUser>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Result<AppUser>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  });

  Future<Result<AppUser>> signInWithGoogle();

  Future<Result<AppUser>> signInWithApple();

  Future<Result<AppUser>> signInAnonymously();

  Future<Result<void>> signOut();

  Future<Result<void>> sendPasswordReset(String email);

  Future<Result<AppUser>> updateProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  });
}
