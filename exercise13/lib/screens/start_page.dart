import 'package:flutter/material.dart';
import '/main.dart';
import 'recipes_grid_screen.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({super.key});

  @override
  StartUpPageState createState() => StartUpPageState();
}

class StartUpPageState extends State<StartUpPage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _positionAnimation = Tween(begin: const Offset(0, 0.25), end: Offset.zero).animate(_controller!);

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onSignIn() {
    _controller!.reverse().then((value) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RecipesGridScreen()), // Assuming this is the main page.
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blueGrey.shade800,
              Colors.blueGrey.shade600,
              Colors.blueGrey.shade400,
              Colors.blueGrey.shade200,
            ], // Adjust the colors to suit your theme
          ),
        ),
        child: FadeTransition(
          opacity: _opacityAnimation!,
          child: SlideTransition(
            position: _positionAnimation!,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Recipe App', // This is the title.
                      style: TextStyle(
                        fontSize: 40, // Bigger font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Bright text color for contrast
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50), // More space between title and button
                    ElevatedButton(
                      onPressed: _onSignIn,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 12.0),
                        child: Text(
                          'Get Started', // Changed text
                          style: TextStyle(
                            fontSize: 24, // Larger font size
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.orange.shade600, // Text color
                        shape: RoundedRectangleBorder( // Rounded corners
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 10.0, // Shadow for a 3D effect
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}