import 'package:flutter/material.dart';

class AppTheme {
  static const Color stressRed = Color(0xFFE57373);
  static const Color stressYellow = Color(0xFFFFD54F);
  static const Color stressGreen = Color(0xFF81C784);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
