import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final List<String> messages = [
      "Welcome to StudyMate! Let's start learning.",
      "You have a new message from your study group.",
      "Reminder: Your next class starts tomorrow at 10 AM.",
      // Add more messages or notifications here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(messages[index]),
              // Optionally, add a trailing icon or some other visual element
            ),
          );
        },
      ),
    );
  }
}
