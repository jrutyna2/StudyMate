import 'package:flutter/material.dart';
import 'package:studymatebeta/screens/courses_screen.dart';
import 'themes/app_theme.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/documents_screen.dart';
import 'screens/login_screen/uog_login_screen.dart';

void main() {
  runApp(StudyMateApp());
}

class StudyMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyMate',
      theme: AppTheme.themeData, // Use your custom theme here
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => LoginScreen(), // Define the login page route
        '/home': (context) => HomePage(), // Define the home page route
        '/courses': (context) => CoursesScreen(),
        '/documents': (context) => DocumentsScreen(), // Define the documents page route
        '/progress': (context) => ProgressTrackerScreen(), // Define the progress page route
        '/schedule': (context) => const ScheduleScreen(), // Define the schedule page route
        '/uogLogin': (context) => const UogLoginScreen(), // New route for UoG Login Screen
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Renamed ChatScreen to HomeScreen
    const ScheduleScreen(),
    ProgressTrackerScreen(), // New screen for tracking progress
    CoursesScreen(), // Add the CoursesScreen to the list
    DocumentsScreen(), // New screen for documents and notes
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36393F), // Dark gray similar to ChatGPT interface
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: const Color(0xFF2F3136), // Dark Gray
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Changed to home icon for clarity
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule), // Kept the schedule icon
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment), // New icon for Progress Tracker
            label: 'Progress', // Naming it "Progress" for brevity
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school), // Icon for Courses
            label: 'Courses', // Label for Courses
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Documents'
          ), // New icon for Documents
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800], // Selected item in blue
        unselectedItemColor: Colors.grey, // color for unselected items
        type: BottomNavigationBarType.fixed, // fixed type to maintain color consistency
        onTap: _onItemTapped,
      ),
    );
  }
}