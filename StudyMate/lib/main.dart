// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/courses_screen.dart';
import 'themes/app_theme.dart'; // Import the theme file
import 'screens/welcome_screen.dart';
import 'screens/course_builder.dart';
import 'screens/course_builder2.dart';
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/accounts_screen.dart';

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
        '/home': (context) => HomeScreen(),
        '/courses': (context) => CoursesScreen(),
        '/chat': (context) => ChatScreen(), // Define the route to your SpecialFeaturesScreen
        '/schedule': (context) => ScheduleScreen(), // Define the route to your ScheduleScreen
        '/account': (context) => AccountScreen(), // Define the route to your AccountScreen
        // Define other routes here
      },
    );
  }
}