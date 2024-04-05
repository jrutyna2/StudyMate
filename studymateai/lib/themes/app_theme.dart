// lib/themes/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.purple,
      colorScheme: const ColorScheme.dark(
        primary: Colors.purple,
        secondary: Colors.purpleAccent,
      ),
      fontFamily: 'Sans-Serif',
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.grey[800]), // Example of making default text color darker
        bodyMedium: TextStyle(color: Colors.grey[800]), // Adjust the color as needed
        // Define other text styles as needed
      ),
    );
  }
}
