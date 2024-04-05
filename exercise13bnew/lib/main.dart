import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../models/favorite_courses_model.dart';
import '../services/course_service.dart';
import '../themes/app_theme.dart';
import '../models/favorite_courses_model.dart'; // Updated to use favorite courses model
import '../themes/app_theme.dart';
import '../models/course.dart'; // Updated to use Course model
import 'screens/start_page.dart'; // Assume this is your app's entry screen, updated as necessary
import '../services/course_service.dart'; // Updated to use CourseService

void main() async {
  // Ensure that Flutter has initialized the framework
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  print("Application Documents Directory: ${directory.path}");

  // Create an instance of CourseService and initialize courses
  final courseService = CourseService();
  await courseService.initCourses(); // Initialize courses instead of recipes

  // Then run the app with updated providers for course data
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteCoursesModel()), // Provide FavoriteCoursesModel here
        Provider(create: (context) => courseService), // Provide CourseService here
      ],
      child: MaterialApp(
        title: 'Course Application',
        theme: AppTheme.darkTheme,
        home: StartPage(), // Ensure StartUpPage is adapted for the course application
      ),
    ),
  );
}
