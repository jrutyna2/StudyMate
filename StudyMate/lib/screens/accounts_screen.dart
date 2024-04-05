import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Example user data - replace with your actual data source
  final String username = "FlutterDev";
  final String email = "flutterdev@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 10),
              Text(
                email,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Implement logout functionality
                  print('User logged out');
                },
                child: Text("Log Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50), // Full width button
                ),
              ),
              // Add more account management options here
            ],
          ),
        ),
      ),
    );
  }
}
