import 'package:flutter/material.dart';

class AppTheme {
  // Define the colors based on the screenshot
  static const Color primaryColor = Color(0xFF0A0E21); // This seems to be the background color
  static const Color accentColor = Color(0xFF1D1F33); // Color for cards or other elements
  static const Color highlightColor = Color(0xFFEB1555); // A highlight color from the graph or buttons
  static const Color textColor = Colors.white; // Text is mostly white

  // The gradient colors for graph
  static const List<Color> graphGradient = [
    Color(0xFFEB1555),
    Color(0xFF0A0E21),
  ];

  // Define text styles
  static const TextStyle headingStyle = TextStyle(
    color: textColor,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle normalTextStyle = TextStyle(
    color: textColor,
    fontSize: 16.0,
  );

  // Define the theme of the app
  static final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: primaryColor,
    primaryColor: primaryColor,
    hintColor: accentColor,
    textTheme: const TextTheme(
      headline6: headingStyle,
      bodyText2: normalTextStyle,
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: accentColor,
      selectedItemColor: highlightColor,
      unselectedItemColor: textColor.withOpacity(0.6),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: highlightColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Method to get the graph gradient
  static LinearGradient getGraphGradient() {
    return const LinearGradient(
      colors: graphGradient,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
