import 'failure.dart';

/// Kết quả của một thao tác có thể thất bại — thay cho `try/catch` ở tầng UI.
///
/// Dùng cùng `switch` exhaustive (Dart 3):
/// ```dart
/// switch (await repo.getNews()) {
///   Ok(:final value) => emit(NewsLoaded(value)),
///   Err(:final failure) => emit(NewsError(failure.message)),
/// }
/// ```
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  T? get valueOrNull => switch (this) {
        Ok<T>(:final value) => value,
        Err<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Ok<T>() => null,
        Err<T>(:final failure) => failure,
      };

  R fold<R>(R Function(T value) onOk, R Function(Failure failure) onErr) {
    return switch (this) {
      Ok<T>(:final value) => onOk(value),
      Err<T>(:final failure) => onErr(failure),
    };
  }

  Result<R> map<R>(R Function(T value) mapper) {
    return switch (this) {
      Ok<T>(:final value) => Ok<R>(mapper(value)),
      Err<T>(:final failure) => Err<R>(failure),
    };
  }
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}

/// Wrap một future, biến exception thành `Err`.
Future<Result<T>> guard<T>(
  Future<T> Function() body, {
  Failure Function(Object error, StackTrace stack)? onError,
}) async {
  try {
    return Ok(await body());
  } catch (e, s) {
    final f = onError?.call(e, s) ?? UnknownFailure(cause: e, stackTrace: s);
    return Err(f);
  }
}
