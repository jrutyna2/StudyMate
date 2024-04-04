import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/login_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_screen/uog_login_screen.dart';


enum SignInService { facebook, google, apple, uog }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  // Controllers to capture input text
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // color: Colors.black, // Set the fallback background color to black
          child: Stack(
            children: [
              buildBackgroundImage(context),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.5, // Half the screen height
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        buildEmailInput(_emailController),
                        const SizedBox(height: 10),
                        buildPasswordInput(_passwordController),
                        const SizedBox(height: 20),
                        buildLoginButton(context, () => _handleLogin(context)),
                        const SizedBox(height: 10),
                        buildRememberMeCheckbox(_rememberMe, _toggleRememberMe, _handleForgotPassword),
                        // buildForgotPasswordButton(_handleForgotPassword),
                        buildOrSeparator(),
                        buildSocialButtons((service) => _handleSignIn(service)),
                        buildSignUpButton(_handleSignUp),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  void _handleLogin(BuildContext context) {
    // TODO: Implement login_screen logic
    print('Login button pressed');
    // Example navigation to '/home' route
    Navigator.pushNamed(context, '/home');
  }

  void _toggleRememberMe(bool? value) {
    setState(() {
      _rememberMe = value ?? false; // If value is null, default to false
    });
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password logic
    print('Forgot password button pressed');
  }

  void _handleSignUp() {
    // TODO: Implement sign up logic
    print('Sign up button pressed');
  }

  void _handleSignIn(SignInService service) {
    switch (service) {
      case SignInService.facebook:
      // Handle Facebook sign-in
        break;
      case SignInService.google:
      // Handle Google sign-in
        break;
      case SignInService.apple:
      // Handle Apple sign-in
        break;
      case SignInService.uog:
      // Handle University of G sign-in
        _launchURL();
        break;
    }
  }

  // Place this method within the LoginScreen widget class
  void _launchURL() async {
    final Uri url = Uri.parse('https://courselink.uoguelph.ca/shared/login/login.html');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch CourseLink'),
        ),
      );
    }
  }
}