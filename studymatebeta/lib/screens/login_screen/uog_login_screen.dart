import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UogLoginScreen extends StatelessWidget {
  const UogLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UoG Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          child: const Text('Login to CourseLink'),
        ),
      ),
    );
  }

  void _launchURL() async {
    final Uri url = Uri.parse('https://courselink.uoguelph.ca/shared/login/login.html');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
