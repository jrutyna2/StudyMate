import 'package:flutter/material.dart';
import '../models/course_manager.dart';
import '../models/course_template.dart';
import '../screens/messages_screen.dart';
import '../screens/my_courses_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '/screens/course_builder.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  void _navigateToMyCourses(BuildContext context) async {
    // Retrieve the list of joined courses
    final List<CourseTemplate> myCourses = await CourseManager().getCourses();

    // Close the drawer
    Navigator.pop(context);

    // Navigate to the My Courses screen, passing the list of joined courses
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCoursesScreen(courses: myCourses),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.purple),
            child: Text('Drawer Header', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Messages'),
            onTap: () {
              // Pop the drawer off the stack
              Navigator.pop(context);
              // Navigate to the MessagesScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessagesScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              // Pop the drawer off the stack
              Navigator.pop(context);
              // Navigate to the ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('My Courses'),
            onTap: () => _navigateToMyCourses(context),
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Build Course'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to Course Creation screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CourseBuilderScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
