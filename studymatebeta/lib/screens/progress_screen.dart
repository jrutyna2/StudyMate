import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/progress_bar.dart'; // You'll need to create a custom widget for the progress bar

class ProgressTrackerScreen extends StatefulWidget {
  @override
  _ProgressTrackerScreenState createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  // Sample data for tasks. In a real app, this could come from a database or state management solution
  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Math Assignment 1",
      "deadline": "2024-03-20",
      "completed": false,
    },
    {
      "title": "Physics Quiz Preparation",
      "deadline": "2024-03-22",
      "completed": true,
    },
    // Add more tasks here...
  ];

  double calculateProgress() {
    int completedTasks = tasks.where((task) => task["completed"] == true).length;
    return completedTasks / tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    double progress = calculateProgress();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Overall Progress', style: Theme.of(context).textTheme.headline6),
          ),
          ProgressBar(progress: progress), // Custom widget to display progress
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Upcoming Tasks', style: Theme.of(context).textTheme.headline6),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task["title"]),
                  subtitle: Text('Deadline: ${task["deadline"]}'),
                  trailing: Icon(task["completed"] ? Icons.check : Icons.close, color: task["completed"] ? Colors.green : Colors.red),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
