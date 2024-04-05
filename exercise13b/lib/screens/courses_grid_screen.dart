import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart'; // Ensure this points to the Course model
import '../services/course_service.dart'; // Use the updated CourseService

class CoursesGridScreen extends StatefulWidget {
  @override
  _CoursesGridScreenState createState() => _CoursesGridScreenState();
}

class _CoursesGridScreenState extends State<CoursesGridScreen> {
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = Provider.of<CourseService>(context, listen: false).loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Courses'),
      ),
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          } else if (snapshot.hasData) {
            final courses = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 4,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      // Navigate to course details
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(course.imageUrl, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(course.title, style: Theme.of(context).textTheme.headline6),
                        ),
                        Text('${course.duration} - ${course.difficulty}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No courses found.'));
          }
        },
      ),
    );
  }
}
