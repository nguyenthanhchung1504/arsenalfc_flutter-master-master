/// Domain-level error. KHÔNG import Flutter/Firebase ở đây.
sealed class Failure implements Exception {
  const Failure(this.message, {this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType($message)';
}

/// Lỗi do mạng (timeout, DNS, ...).
final class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'Lỗi kết nối mạng.',
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message, cause: cause, stackTrace: stackTrace);
}

/// Server trả về lỗi (HTTP >= 400).
final class ServerFailure extends Failure {
  const ServerFailure({
    String message = 'Máy chủ trả về lỗi.',
    this.statusCode,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message, cause: cause, stackTrace: stackTrace);

  final int? statusCode;
}

/// Lỗi xác thực (token sai, hết hạn, không có quyền).
final class AuthFailure extends Failure {
  const AuthFailure({
    String message = 'Phiên đăng nhập không hợp lệ.',
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message, cause: cause, stackTrace: stackTrace);
}

/// Lỗi tại Firestore / database client.
final class DatabaseFailure extends Failure {
  const DatabaseFailure({
    String message = 'Lỗi cơ sở dữ liệu.',
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message, cause: cause, stackTrace: stackTrace);
}

/// Lỗi parse dữ liệu (JSON/DTO không hợp lệ).
final class ParseFailure extends Failure {
  const ParseFailure({
    String message = 'Dữ liệu trả về không hợp lệ.',
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message, cause: cause, stackTrace: stackTrace);
}

/// Lỗi do logic nghiệp vụ (validation, ràng buộc).
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Tính năng chưa làm xong — dùng làm stub trong giai đoạn refactor.
final class NotImplementedFailure extends Failure {
  const NotImplementedFailure([String message = 'Chức năng chưa khả dụng.'])
      : super(message);
}

/// Lỗi không xác định, bọc exception bất kỳ.
final class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'Đã xảy ra lỗi không xác định.',
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message, cause: cause, stackTrace: stackTrace);
}
