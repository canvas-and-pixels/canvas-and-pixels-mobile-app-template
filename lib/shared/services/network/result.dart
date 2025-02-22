/// A functional result type representing either a success or failure.
///
/// Example:
/// ```dart
/// Result<int, String> success = Result.success(200);
/// Result<int, String> failure = Result.failure("Network error");
/// ```
class Result<T, E> {
  final T? value;
  final E? error;

  const Result._({this.value, this.error});

  bool get isSuccess => value != null;
  bool get isFailure => error != null;

  static Result<T, E> success<T, E>(T value) => Result._(value: value);
  static Result<T, E> failure<T, E>(E error) => Result._(error: error);

  /// Maps a successful value to another type while keeping errors unchanged.
  Result<R, E> map<R>(R Function(T value) transform) {
    return isSuccess ? Result.success(transform(value as T)) : Result.failure(error as E);
  }

  /// Runs a function if success, otherwise keeps the error.
  Result<T, E> onSuccess(void Function(T value) action) {
    if (isSuccess) action(value as T);
    return this;
  }

  /// Runs a function if failure.
  Result<T, E> onFailure(void Function(E error) action) {
    if (isFailure) action(error as E);
    return this;
  }
}
