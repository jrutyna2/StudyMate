import 'package:flutter/material.dart';
import '/models/course_template.dart'; // Update this path
import '/widgets/course_template_card.dart';
import 'course_details_screen.dart'; // Update this path

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<CourseTemplate> courses = [
    CourseTemplate(
      id: '1',
      imageUrl: 'https://i.pinimg.com/474x/69/2e/9f/692e9f4ed02224eab31ae521e3a04f0c.jpg',
      title: 'Flutter for Beginners',
      description: 'An introductory course to Flutter development.',
      rating: 4.5,
    ),
    CourseTemplate(
      id: '2',
      imageUrl: 'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*WZFChxzTacQXXK3hPoyP2g@2x.jpeg',
      title: 'Advanced Flutter Concepts',
      description: 'Dive deeper into Flutter development with advanced concepts and techniques.',
      rating: 4.8,
    ),
    CourseTemplate(
      id: '3',
      imageUrl: 'https://i.pinimg.com/736x/75/83/b7/7583b7e2122ac387585eb0d4284f1f25.jpg',
      title: 'Flutter UI & UX Design',
      description: 'Learn how to create beautiful and user-friendly interfaces with Flutter.',
      rating: 4.6,
    ),
    CourseTemplate(
      id: '4',
      imageUrl: 'https://i.pinimg.com/474x/40/6c/b8/406cb8106b02635beb6b86fae39ec13d.jpg',
      title: 'State Management in Flutter',
      description: 'Master state management in Flutter for more efficient and scalable apps.',
      rating: 4.7,
    ),
    CourseTemplate(
      id: '5',
      imageUrl: 'https://i.pinimg.com/474x/11/e1/52/11e15217c5cb043e6e66cfa6dd0d980a.jpg',
      title: 'Integrating APIs and Web Services',
      description: 'Learn how to integrate external APIs and web services into your Flutter apps.',
      rating: 4.4,
    ),
    CourseTemplate(
      id: '6',
      imageUrl: 'https://i.pinimg.com/474x/e4/7b/3b/e47b3b91f8aef7ddeff22720c2b1bd1a.jpg',
      title: 'Building Cross-Platform Apps with Flutter',
      description: 'Develop cross-platform applications for iOS and Android with a single codebase.',
      rating: 4.9,
    ),
  ];


  // This will hold the filtered courses based on the search query
  List<CourseTemplate> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    // Initially, all courses are shown
    filteredCourses = courses;
  }

  void _searchCourse(String query) {
    final suggestions = courses.where((course) {
      final courseTitle = course.title.toLowerCase();
      final input = query.toLowerCase();
      return courseTitle.contains(input);
    }).toList();
    setState(() {
      filteredCourses = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CoursesSearch(courses: courses));
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredCourses.length,
        itemBuilder: (context, index) {
          final course = filteredCourses[index];
          return InkWell(
            onTap: () {
              // Navigate to the CourseDetailScreen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(course: course),
                ),
              );
            },
            child: CourseTemplateCard(template: course), // Your existing course card
          );
        },
      ),
    );
  }
}

class CoursesSearch extends SearchDelegate<CourseTemplate> {
  final List<CourseTemplate> courses;

  CoursesSearch({required this.courses});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, CourseTemplate(id: '', imageUrl: '', title: '', description: '', rating: 0)); // Return an empty course on close
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = courses.where((course) {
      return course.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final course = suggestions[index];
        return ListTile(
          title: Text(course.title),
          onTap: () {
            // Navigate to the CourseDetailScreen with the selected course
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CourseDetailScreen(course: course),
            ));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = courses.where((course) {
      return course.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final course = suggestions[index];
        return ListTile(
          title: Text(course.title),
          onTap: () {
            // Navigate to the CourseDetailScreen with the selected course
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CourseDetailScreen(course: course),
            ));
          },
        );
      },
    );
  }

}
