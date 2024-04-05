import 'package:flutter/material.dart';
import '/models/course_template.dart'; // Update this path
import '/models/course_manager.dart'; // Import the CourseManager

class CourseDetailScreen extends StatelessWidget {
  final CourseTemplate course;

  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);

  Future<void> _joinCourse(BuildContext context) async {
    // Assuming CourseManager is properly set up to handle adding a course
    await CourseManager().addCourse(course);
    // Show a SnackBar as feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You have joined "${course.title}"')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(course.imageUrl),
            SizedBox(height: 20),
            Text(
              course.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Rating: ${course.rating}/5',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Text(
              course.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Optionally display course content if not empty
            if (course.content.isNotEmpty)
              Text(
                course.content,
                style: TextStyle(fontSize: 16),
              ),
            ElevatedButton(
              onPressed: () => _joinCourse(context),
              child: Text('Join Course'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set the background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
