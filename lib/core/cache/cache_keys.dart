enum CacheKey {
  username,
  userToken,
  userPreferences,
  isLoggedIn,
  themeMode,
}

/// Extension to provide string keys for each [CacheKey].
///
/// This avoids hardcoded string keys and maintains consistency.
extension CacheKeyExtension on CacheKey {
  /// Returns the string representation of the [CacheKey].
  String get key {
    switch (this) {
      case CacheKey.username:
        return 'cache_username';
      case CacheKey.userToken:
        return 'cache_user_token';
      case CacheKey.userPreferences:
        return 'cache_user_preferences';
      case CacheKey.isLoggedIn:
        return 'cache_is_logged_in';
      case CacheKey.themeMode:
        return 'cache_theme_mode';
    }
  }
}
