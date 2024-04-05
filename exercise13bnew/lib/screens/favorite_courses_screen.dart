import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../models/favorite_courses_model.dart';
import '../services/course_service.dart';
import 'course_screen.dart'; // Updated to navigate to the CourseScreen

class FavoriteCoursesScreen extends StatelessWidget {
  final List<Course> favoriteCourses;

  const FavoriteCoursesScreen({super.key, required this.favoriteCourses});

  @override
  Widget build(BuildContext context) {
    // Fetching favorite courses from FavoriteCoursesModel provided higher in the widget tree
    final favoriteCourses = Provider.of<FavoriteCoursesModel>(context).favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Courses'), // Updated title to reflect courses
      ),
      body: ListView.builder(
        itemCount: favoriteCourses.length,
        itemBuilder: (context, index) {
          final course = favoriteCourses[index];
          return Semantics(
            label: 'Course ${course.title} from ${course.categories}', // Updated to course details
            hint: 'Double tap to view course details',
            child: Card(
              child: ListTile(
                leading: ExcludeSemantics(
                  child: Image.network(
                    course.imageUrl,
                    fit: BoxFit.cover,
                    width: 100.0,
                    semanticLabel: 'Image of the course ${course.title}', // Updated description
                  ),
                ),
                title: Text(course.title), // Display the course title
                subtitle: Text('Category: ${course.categories}'), // Display the course instructor

                // On tap, navigate to the CourseScreen to view course details
                onTap: () async {
                  final deletionResult = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CourseScreen(course: course), // Navigate to CourseScreen
                    ),
                  );

                  // If a course was unenrolled, refresh the favorites screen
                  if (deletionResult == true) {
                    Navigator.of(context).pop(true); // Pass 'true' up the navigation stack for any necessary updates
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
