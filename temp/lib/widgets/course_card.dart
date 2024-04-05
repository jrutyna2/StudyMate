import 'package:flutter/material.dart';
import '../models/course.dart';
import '../screens/course_screen.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap; // Add a callback for tap events

  const CourseCard({
    Key? key,
    required this.course,
    required this.onTap, // Require the callback in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the CourseScreen to view details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseScreen(course: course),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to fill Card width
          children: <Widget>[
            Expanded(
              child: Image.network(
                course.imageUrl,
                fit: BoxFit.cover,
                semanticLabel: 'Image of the course ${course.title}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Duration: ${course.duration}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Difficulty: ${course.difficulty}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
