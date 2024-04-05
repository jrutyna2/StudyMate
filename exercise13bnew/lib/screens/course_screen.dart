import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_courses_model.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import '../utils/sliver_appbar_delegate.dart';

class CourseScreen extends StatelessWidget {
  final Course course;
  const CourseScreen({super.key, required this.course});

  void _confirmUnenroll(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unenroll from Course'),
          content: const Text('Are you sure you want to unenroll from this course?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
            ),
            // Wrap the button that triggers unenrollment with a Builder
            Builder(
              builder: (BuildContext context) {
                return TextButton(
                  child: const Text('Unenroll'),
                  onPressed: () async {
                    try {
                      // Assuming a method to handle unenrollment
                      await Provider.of<CourseService>(context, listen: false).deleteCourse(course.id);
                      print("Unenrollment successful");

                      Provider.of<FavoriteCoursesModel>(context, listen: false).unenroll(course);
                      // Use the context provided by Builder
                      Navigator.of(context).pop(true);
                    } catch (e) {
                      print("Error during unenrollment: $e");
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(course.title), // Title in the navigation bar
            pinned: true, // Pin the navigation bar
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () => _confirmUnenroll(context),
              ),
            ],
          ),
          SliverPersistentHeader(
            delegate: SliverAppBarDelegate(
              minHeight: 200.0, // The minimum height when scrolled up
              maxHeight: 200.0, // The maximum height before scrolling
              child: Image.network(
                course.imageUrl,
                fit: BoxFit.cover,
              ), // The image
            ),
            pinned: true, // Pin the image
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Categories: ${course.categories}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Description: ${course.description}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Modules:",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: course.modules.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        String module = entry.value;
                        return Chip(
                          label: Text('$index. $module'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              // Similar updates for other sections like Materials, Requirements, etc.
            ]),
          ),
        ],
      ),
    );
  }
}
