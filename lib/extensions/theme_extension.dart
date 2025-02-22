import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  /// Checks if the app is currently in dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Returns primary color based on theme mode
  Color get primaryColor => Theme.of(this).primaryColor;

  /// Returns text color based on theme mode
  Color get textColor => isDarkMode ? Colors.white : Colors.black;

  /// Returns scaffold background color based on theme mode
  Color get scaffoldBackground => Theme.of(this).scaffoldBackgroundColor;
}
