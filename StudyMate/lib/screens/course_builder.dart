import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'course_builder2.dart';

class CourseBuilderScreen extends StatefulWidget {
  const CourseBuilderScreen({super.key});

  @override
  CourseBuilderScreenState createState() => CourseBuilderScreenState();
}

class CourseBuilderScreenState extends State<CourseBuilderScreen> {
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _courseDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Use a map to manage modules and their associated files
  Map<String, List<File>> modules = {};

  Future<void> pickFiles(String moduleName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        // Add files to the corresponding module
        if (modules.containsKey(moduleName)) {
          modules[moduleName]?.addAll(files);
        } else {
          modules[moduleName] = files;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Builder"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _courseTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Course Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a course title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _courseDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Course Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a course description';
                    }
                    return null;
                  },
                  maxLines: null,
                ),
                const SizedBox(height: 20),
                Text("Modules:", style: Theme.of(context).textTheme.titleLarge),
                ...modules.keys.map((moduleName) {
                  return ListTile(
                    title: Text(moduleName),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => pickFiles(moduleName),
                    ),
                  );
                }),
                ElevatedButton(
                  onPressed: () {
                    // Placeholder for functionality to add a new module
                  },
                  child: const Text('Add New Module'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle course creation here
                    }
                  },
                  child: const Text('Save Course'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CourseBuilderScreen2()),
          );
        },
        child: const Icon(Icons.help_outline),
      ),
    );
  }
}
