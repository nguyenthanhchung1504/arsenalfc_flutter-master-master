import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Tạo `Dio` chuẩn cho app — base URL truyền vào, interceptor mặc định log debug.
Dio createDio({
  required String baseUrl,
  Duration timeout = const Duration(seconds: 20),
  Map<String, String>? headers,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      headers: {
        'Accept': 'application/json',
        ...?headers,
      },
      responseType: ResponseType.json,
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: false,
        error: true,
      ),
    );
  }

  return dio;
}
