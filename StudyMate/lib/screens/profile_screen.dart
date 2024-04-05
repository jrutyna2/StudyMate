import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with actual user data
    const String username = 'John Doe';
    const String email = 'johndoe@example.com';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Placeholder image
            ),
            SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            // Add more profile details here
          ],
        ),
      ),
    );
  }
}
