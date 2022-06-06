import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFFFFFFF),
      onError: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFFFFFFFF),
    ));
  }
}