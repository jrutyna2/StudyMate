import 'package:flutter/material.dart';
import '/screens/course_builder.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

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
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('My Courses'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to My Courses screen
            },
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
