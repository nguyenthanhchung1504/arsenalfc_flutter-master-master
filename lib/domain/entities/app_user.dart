enum UserRole { guest, user, admin }

class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.role = UserRole.user,
    this.isAnonymous = false,
  });

  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final UserRole role;
  final bool isAnonymous;

  bool get isAdmin => role == UserRole.admin;

  static const AppUser guest = AppUser(
    uid: '',
    role: UserRole.guest,
    isAnonymous: true,
  );

  @override
  bool operator ==(Object other) => other is AppUser && other.uid == uid;

  @override
  int get hashCode => uid.hashCode;
}
