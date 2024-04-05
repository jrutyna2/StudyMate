// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '/widgets/home_drawer.dart';
import '/widgets/bottom_navigation_bar.dart';
import '/widgets/feature_card.dart';

class HomeScreen extends StatefulWidget {
  // Add a key constructor if necessary
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Check if the "Courses" item is tapped
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CoursesGridScreen()),
      );
    }

    // Implement navigation for other indices as needed
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set the key here
      appBar: AppBar(
        title: const Text('Account'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Use the key to open the drawer
          },
        ),
      ),
      drawer: const HomeDrawer(),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.white70),
            title: const Text('Account details'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          // ... Add other ListTiles
          FeatureCard(
            title: 'Got an idea?',
            description: 'Tell us how we can make your Kraken experience better.',
            onPressed: () {
              // Define what happens when the button is pressed
            },
          ),
          // ... Add other settings options
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
