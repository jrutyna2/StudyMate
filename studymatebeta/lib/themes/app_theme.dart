// Import Flutter material package
import 'package:flutter/material.dart';

// Define a class to hold your theme data
class AppTheme {
  // Define a static ThemeData for easy access throughout your app
  static ThemeData get themeData {
    // Return ThemeData
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.lightBlueAccent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2F3136),//Colors.lightBlueAccent,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlueAccent,
      ),
      scaffoldBackgroundColor: const Color(0xFF36393F),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF2F3136),
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
      // Add other theme data here
    );
  }
}
