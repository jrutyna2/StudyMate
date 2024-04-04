// lib/main.dart
import 'package:flutter/material.dart';
import 'themes/app_theme.dart'; // Import the theme file
import 'screens/welcome_screen.dart';
import 'screens/course_builder.dart';
import 'screens/course_builder2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudaMigo',
      theme: AppTheme.darkTheme,
      home: const WelcomeScreen(),
      routes: {
        '/courseBuilder': (context) => const CourseBuilderScreen(),
        '/courseBuilder2': (context) => const CourseBuilderScreen2(),
        // Define other routes here
      },
    );
  }
}
