import 'package:connectivity_plus/connectivity_plus.dart';

/// Kiểm tra kết nối mạng (thay `internet_connection_checker`).
class NetworkInfo {
  NetworkInfo._();

  static Future<bool> get hasConnection async {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
}
