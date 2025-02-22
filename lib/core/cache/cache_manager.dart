import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'cache_keys.dart';

/// A utility class for managing local caching using SharedPreferences.
///
/// This class provides a generic caching system that allows storing,
/// retrieving, and removing different types of data such as Strings,
/// Integers, Booleans, Lists, and JSON objects.
///
/// ## Usage:
/// Before using the cache system, ensure `CacheManager.init()` is called in `main.dart`:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await CacheManager.init();
///   runApp(MyApp());
/// }
/// ```
///
/// Example usage:
/// ```dart
/// await CacheManager.saveString(CacheKey.username, "JohnDoe");
/// String? username = CacheManager.getString(CacheKey.username);
/// print(username); // Output: JohnDoe
/// ```
class CacheManager {
  static late SharedPreferences _prefs;

  /// Initializes SharedPreferences.
  ///
  /// Must be called before using any caching functions.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Saves a [String] value with the given [CacheKey].
  ///
  /// Example:
  /// ```dart
  /// await CacheManager.saveString(CacheKey.username, "JohnDoe");
  /// ```
  static Future<void> saveString(CacheKey key, String value) async {
    await _prefs.setString(key.key, value);
  }

  /// Retrieves a [String] value stored with the given [CacheKey].
  ///
  /// Returns `null` if the key does not exist.
  ///
  /// Example:
  /// ```dart
  /// String? username = CacheManager.getString(CacheKey.username);
  /// ```
  static String? getString(CacheKey key) {
    return _prefs.getString(key.key);
  }

  /// Saves an [int] value with the given [CacheKey].
  ///
  /// Example:
  /// ```dart
  /// await CacheManager.saveInt(CacheKey.userId, 123);
  /// ```
  static Future<void> saveInt(CacheKey key, int value) async {
    await _prefs.setInt(key.key, value);
  }

  /// Retrieves an [int] value stored with the given [CacheKey].
  ///
  /// Returns `null` if the key does not exist.
  ///
  /// Example:
  /// ```dart
  /// int? userId = CacheManager.getInt(CacheKey.userId);
  /// ```
  static int? getInt(CacheKey key) {
    return _prefs.getInt(key.key);
  }

  /// Saves a [bool] value with the given [CacheKey].
  ///
  /// Example:
  /// ```dart
  /// await CacheManager.saveBool(CacheKey.isLoggedIn, true);
  /// ```
  static Future<void> saveBool(CacheKey key, bool value) async {
    await _prefs.setBool(key.key, value);
  }

  /// Retrieves a [bool] value stored with the given [CacheKey].
  ///
  /// Returns `null` if the key does not exist.
  ///
  /// Example:
  /// ```dart
  /// bool? isLoggedIn = CacheManager.getBool(CacheKey.isLoggedIn);
  /// ```
  static bool? getBool(CacheKey key) {
    return _prefs.getBool(key.key);
  }

  /// Saves a JSON [Map] as a [String] using the given [CacheKey].
  ///
  /// The object is converted to a JSON string before saving.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> user = {"id": 1, "name": "John Doe"};
  /// await CacheManager.saveObject(CacheKey.userPreferences, user);
  /// ```
  static Future<void> saveObject(
      CacheKey key, Map<String, dynamic> value) async {
    String jsonString = jsonEncode(value);
    await _prefs.setString(key.key, jsonString);
  }

  /// Retrieves a JSON [Map] stored with the given [CacheKey].
  ///
  /// Returns `null` if the key does not exist.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic>? user = CacheManager.getObject(CacheKey.userPreferences);
  /// print(user?["name"]); // Output: John Doe
  /// ```
  static Map<String, dynamic>? getObject(CacheKey key) {
    String? jsonString = _prefs.getString(key.key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  /// Removes a specific cache entry using the given [CacheKey].
  ///
  /// Example:
  /// ```dart
  /// await CacheManager.remove(CacheKey.username);
  /// ```
  static Future<void> remove(CacheKey key) async {
    await _prefs.remove(key.key);
  }

  /// Clears all cached data.
  ///
  /// Example:
  /// ```dart
  /// await CacheManager.clear();
  /// ```
  static Future<void> clear() async {
    await _prefs.clear();
  }
}
