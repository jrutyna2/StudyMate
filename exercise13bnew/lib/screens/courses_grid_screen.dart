import 'package:exercise12/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../models/favorite_courses_model.dart';
import '../services/course_service.dart';
import '../widgets/course_card.dart';
import 'favorite_courses_screen.dart';
import 'new_course_screen.dart';
import 'course_screen.dart';

class CoursesGridScreen extends StatefulWidget {
  const CoursesGridScreen({super.key});

  @override
  CoursesGridScreenState createState() => CoursesGridScreenState();
}

class CoursesGridScreenState extends State<CoursesGridScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Course>>? _coursesFuture;
  List<Course> favoriteCourses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    final courseService = Provider.of<CourseService>(context, listen: false);
    setState(() {
      _coursesFuture = courseService.loadCourses();
    });
  }

  //updates the state
  void toggleFavorite(Course course) {
    final model = Provider.of<FavoriteCoursesModel>(context, listen: false);
    if (model.isFavorite(course)) {
      model.removeFavorite(course);
    } else {
      model.addFavorite(course);
    }
    // Ensure the course object in your list is also updated
    course.isFavorite = !course.isFavorite;
  }

  void _navigateAndPossiblyRefresh(BuildContext context, Course course) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseScreen(course: course),
      ),
    );

    if (result == true) {
      setState(() {
        _coursesFuture = Provider.of<CourseService>(context, listen: false).loadCourses();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseService = Provider.of<CourseService>(context, listen: false);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Available Courses'),
          actions: <Widget>[

            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewCourseScreen(),
                  ),
                );
                setState(() {
                  _coursesFuture = Provider.of<CourseService>(context, listen: false).loadCourses();
                });
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero, // Remove padding from the ListView.
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Semantics(
                  header: true,
                  child: const Text('Course App'), // Mark it as a header for semantic purposes.
                ),
              ),

              Semantics(
                button: true,
                label: 'Navigate to Courses Grid Screen',
                child: ListTile(
                  title: const Text('Courses'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesGridScreen()));
                  },
                ),
              ),

              Semantics(
                button: true,
                label: 'Navigate to Favourite Courses Screen',
                child: ListTile(
                  title: const Text('Favourite Courses'),
                  // Inside the onTap callback for the 'Favourite Courses' ListTile in the drawer
                  onTap: () async {
                    final deletionHappened = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FavoriteCoursesScreen(favoriteCourses: [])),
                    );
                    if (deletionHappened == true) {
                      print('Deletion happened, refreshing courses list.');
                      _loadCourses(); // Call this method to refresh the courses list
                    }
                  },
                ),
              ),

              Semantics(
                button: true,
                label: 'Navigate to Settings Screen',
                child: ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer before navigating.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder<List<Course>>(
          future: _coursesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No courses found.'));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final course = snapshot.data![index];
                  return CourseCard(
                    course: course,
                    onTap: () => _navigateAndPossiblyRefresh(context, course),
                  );
                },
              );
            }
          },
        )
    );
  }
}
