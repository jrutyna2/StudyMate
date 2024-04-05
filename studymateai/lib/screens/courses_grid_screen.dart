import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_course_model.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import 'favorites_screen.dart';
import 'new_course_screen.dart';
import 'course_screen.dart';
import 'settings_screen.dart'; // You'll create this for loadCourses function

class CoursesGridScreen extends StatefulWidget {
  const CoursesGridScreen({super.key});

  @override
  CoursesGridScreenState createState() => CoursesGridScreenState();
}

class CoursesGridScreenState extends State<CoursesGridScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Course>>? _coursesFuture;
  List<Course> favoriteCourses = []; // Initialize favoriteCourses list
  // @override
  // void initState() {
  //   super.initState();
  //   final courseService = Provider.of<CourseService>(context, listen: false);
  //   _coursesFuture = courseService.loadCourses(); // Use CourseService to load courses
  // }
  @override
  void initState() {
    super.initState();
    _loadCourses(); // This will call the method to set the _coursesFuture
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
      model.remove(course);
    } else {
      model.add(course);
    }
    // Ensure the course object in your list is also updated
    course.favourite = !course.favourite;
  }

  // When you navigate to CourseScreen from CoursesGridScreen
  void _navigateAndPossiblyRefresh(BuildContext context, Course course) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseScreen(course: course),
      ),
    );

    // If the result is true, refresh your courses list
    if (result == true) {
      setState(() {
        // Assuming you have a method to reload the courses
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
          title: const Text('Explore'),
          actions: <Widget>[

            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                // Await the return from NewCourseScreen
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewCourseScreen(),
                  ),
                );
                // Once NewCourseScreen is popped, refresh the list of courses
                setState(() {
                  // Assuming _coursesFuture is your Future variable for loading courses
                  _coursesFuture = courseService.loadCourses();
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
                      MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteCourses: [])),
                    );
                    if (deletionHappened == true) {
                      print('Deletion happened, refreshing courses list.');
                      _loadCourses(); // Call this method to refresh the courses list
                    }
                  },

                  // onTap: () {
                  //   Navigator.pop(context); // Close the drawer before navigating.
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteCourses: [])));
                  // },
                  // Inside the CoursesGridScreen's Drawer, ListTile for Favourite Courses
                  // onTap: () async {
                  //   // Navigate to the FavouritesScreen
                  //   final deletionHappened = await Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteCourses: [])),
                  //   );
                  //   // If a deletion happened, refresh the grid
                  //   if (deletionHappened == true) {
                  //     _refreshCoursesAfterDeletion();
                  //   }
                  // },
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

        // Use FutureBuilder to wait for the courses data to be loaded
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
                  return Semantics(
                    label: 'Course card for ${course.title}',
                    hint: 'Double tap to open course details',
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [

                          Positioned.fill(
                            child: Image.network(
                              course.imageUrl,
                              fit: BoxFit.cover,
                              semanticLabel: 'Image of the course ${course.title}', // Provide a description for screen readers
                            ),
                          ),

                          Positioned.fill(
                            child: Container(
                              height: 180.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), // Dim the image with a semi-transparent overlay
                              ),
                            ),
                          ),

                          Positioned(
                            top: 8.0,
                            left: 8.0,
                            child: Semantics(
                              label: 'Course author ${course.author}',
                              child: Text(
                                course.author,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 35.0,
                            left: 8.0,
                            child: Semantics(
                              label: 'Course title ${course.title}',
                              child: Text(
                                course.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 12.0,
                            right: 0.0,
                            left: 0.0,
                            child: Semantics(
                              label: 'Course details: ${course.speed} minutes to cook, costs ${course.amount}, difficulty rating: ${course.difficulty}',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.timer, color: Colors.white, size: 18.0),
                                  const SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      course.speed,
                                      style: const TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.attach_money, color: Colors.white, size: 18.0),
                                  const SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      course.amount,
                                      style: const TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.star, color: Colors.white, size: 18.0),
                                  const SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      course.difficulty,
                                      style: const TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(

                                onTap: () => _navigateAndPossiblyRefresh(context, course),

                                // Providing a semantic label for the entire card
                                child: Semantics(
                                  label: '${course.title} by ${course.author}. Tap for details.',
                                  excludeSemantics: true, // We're using the parent Semantics instead
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: IconButton(
                              icon: Icon(course.favourite ? Icons.favorite : Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () {

                                setState(() {
                                  toggleFavorite(course);
                                });

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}
