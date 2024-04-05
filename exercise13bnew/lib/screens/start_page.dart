import 'package:flutter/material.dart';
import 'courses_grid_screen.dart'; // Assuming this points to a functional screen

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CoursesGridScreen()));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor, // Text color
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 20),
            ),
            child: Text('Explore Courses'),
          ),
        ),
      ),
    );
  }
}
