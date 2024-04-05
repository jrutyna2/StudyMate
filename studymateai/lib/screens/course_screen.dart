// show rootBundle;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_course_model.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import '../utils/sliver_appbar_delegate.dart';

class CourseScreen extends StatelessWidget {
  final Course course;
  const CourseScreen({super.key, required this.course});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Course'),
          content: const Text('Are you sure you want to delete this course?'),
          actions: <Widget>[

            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
            ),

            // Wrap the button that triggers deletion with a Builder
            Builder(
              builder: (BuildContext context) {
                return TextButton(
                  child: const Text('Delete'),
                  onPressed: () async {
                    try {
                      await Provider.of<CourseService>(context, listen: false).deleteCourse(course.title);
                      print("Deletion successful");

                      Provider.of<FavoriteCoursesModel>(context, listen: false).remove(course);
                      // Use the context provided by Builder
                      Navigator.of(context).pop(true);
                    } catch (e) {
                      print("Error during deletion: $e");
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
                icon: const Icon(Icons.delete),
                onPressed: () => _confirmDelete(context),
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
                  'Author: ${course.author}',
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
                      "Ingredients:",
                      style: TextStyle(
                        fontSize: 18.0, // Choose an appropriate font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: course.ingredients.asMap().entries.map((entry) {
                        int index = entry.key + 1; // Adding 1 because list is zero-based
                        String ingredient = entry.value;
                        return Chip(
                          label: Text('$index. $ingredient'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              // For Cooking Time
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Semantics(
                  label: 'Cooking Time',
                  child: Row(
                    children: [
                      const Text(
                        "Time to Cook: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${course.time} mins',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // For Directions
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Semantics(
                  label: 'Cooking Directions',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Directions:',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      ...course.directions.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        String direction = entry.value;
                        return Semantics(
                          label: 'Step $index',
                          child: Text(
                            '$index. $direction',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}