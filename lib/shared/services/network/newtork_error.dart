/// A class representing different types of network errors.
sealed class NetworkError {
  final String message;

  const NetworkError(this.message);
}

/// Specific error cases.
class TimeoutError extends NetworkError {
  const TimeoutError() : super('Request timeout. Please try again.');
}

class NoInternetError extends NetworkError {
  const NoInternetError() : super('No internet connection.');
}

class ServerError extends NetworkError {
  final int statusCode;
  const ServerError(this.statusCode, String message) : super(message);
}

class UnknownError extends NetworkError {
  const UnknownError() : super('An unknown error occurred.');
}
