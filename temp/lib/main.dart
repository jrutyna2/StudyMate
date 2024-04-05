import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'lib/models/favorite_courses_model.dart';
import 'lib/services/course_service.dart';
import 'lib/models/favorite_courses_model.dart'; // Updated to use favorite courses model
import 'lib/models/course.dart'; // Updated to use Course model
import 'lib/screens/start_page.dart'; // Assume this is your app's entry screen, updated as necessary
import 'lib/services/course_service.dart'; // Updated to use CourseService

void main() async {
  // Ensure that Flutter has initialized the framework
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  print("Application Documents Directory: ${directory.path}");

  // Create an instance of CourseService and initialize courses
  final courseService = CourseService();
  await courseService.initCourses();

  // Now, load the courses and update the favorite courses model
  List<Course> courses = await courseService.loadCourses();

  // Then run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteCoursesModel()),
        Provider(create: (context) => courseService), // Provide CourseService here
      ],
      child: MaterialApp(
        title: 'Exercise Twelve',
        theme: ThemeData(
          // Define your app theme here
        ),
        home: StartUpPage(), // Removed the courseService parameter
      ),
    ),
  );
}
