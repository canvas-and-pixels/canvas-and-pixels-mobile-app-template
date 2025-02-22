import 'dart:developer' as developer;

/// A configurable custom logger with ANSI color support and initialization.
class AppLogger {
  // ANSI color codes for console logging
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  static bool _isEnabled = true;
  static bool _logErrorsOnly = false;

  /// Initializes the logger with optional configurations.
  static void init({bool isEnabled = true, bool logErrorsOnly = false}) {
    _isEnabled = isEnabled;
    _logErrorsOnly = logErrorsOnly;
  }

  /// Logs a debug message (cyan).
  static void debug(String message, {String tag = 'DEBUG'}) {
    if (_shouldLog()) {
      developer.log('$cyan[$tag] $message$reset', name: 'AppLogger');
    }
  }

  /// Logs an info message (blue).
  static void info(String message, {String tag = 'INFO'}) {
    if (_shouldLog()) {
      developer.log('$blue[$tag] $message$reset', name: 'AppLogger');
    }
  }

  /// Logs a warning message (yellow).
  static void warning(String message, {String tag = 'WARNING'}) {
    if (_shouldLog()) {
      developer.log('$yellow[$tag] ⚠️ $message$reset', name: 'AppLogger');
    }
  }

  /// Logs an error message (red) with optional stack trace.
  static void error(String message,
      {Object? error, StackTrace? stackTrace, String tag = 'ERROR'}) {
    if (_isEnabled) {
      developer.log('$red[$tag] ❌ $message$reset',
          name: 'AppLogger', error: error, stackTrace: stackTrace);
    }
  }

  /// Logs a success message (green).
  static void success(String message, {String tag = 'SUCCESS'}) {
    if (_shouldLog()) {
      developer.log('$green[$tag] ✅ $message$reset', name: 'AppLogger');
    }
  }

  /// Determines if logging should be enabled based on configuration.
  static bool _shouldLog() {
    return _isEnabled && !_logErrorsOnly;
  }
}
