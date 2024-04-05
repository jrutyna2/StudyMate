import 'package:flutter/material.dart';
import 'login_screen.dart'; // Make sure to create this screen and adjust the import path accordingly

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade300,
                Colors.green.shade200,
              ],
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _opacity!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Welcome to Our App!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Get started by logging in or signing up.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text('Get Started'),
                  ),
                  // const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Navigate to the sign up screen if you have one
                  //   },
                  //   child: const Text('Sign Up'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
