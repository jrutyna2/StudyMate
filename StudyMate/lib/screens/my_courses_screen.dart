import 'package:flutter/material.dart';
import '/models/course_template.dart';
import '/widgets/course_template_card.dart';
import 'course_details_screen.dart'; // Make sure to import the course template card widget

class MyCoursesScreen extends StatelessWidget {
  final List<CourseTemplate> courses;

  const MyCoursesScreen({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
      ),
      body: courses.isNotEmpty
          ? GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of cards in a row
          crossAxisSpacing: 10, // Spacing between cards horizontally
          mainAxisSpacing: 10, // Spacing between cards vertically
          childAspectRatio: 0.8, // Aspect ratio of the cards
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseTemplateCard(
            template: course,
            onTap: () {
              // Handle navigation to course details, if needed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(course: course),
                ),
              );
            },
          );
        },
      )
          : Center(
        child: Text(
          'No courses joined yet. Start exploring and join courses now!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
