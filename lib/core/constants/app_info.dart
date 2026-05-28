/// Thông tin định danh app — dùng thay hardcode trong UI/share/rate.
class AppInfo {
  AppInfo._();

  static const String displayName = 'Gooner Vietnam';
  static const String androidPackage = 'vn.afcvn.app';
  static const String iosBundleId = 'vn.afcvn.app';

  /// App Store ID cũ (Offical AFCVN) — cập nhật khi publish listing mới.
  static const String iosAppStoreId = '6445896310';

  static String get playStoreUrl =>
      'https://play.google.com/store/apps/details?id=$androidPackage&hl=vi-VN';

  static String get appStoreUrl =>
      'https://apps.apple.com/vn/app/id$iosAppStoreId?l=vi';
}
