import 'package:flutter/material.dart';
import '../models/course.dart'; // Ensure this points to your Course model

class AddEditCourseScreen extends StatefulWidget {
  final Course? course; // Pass a course if you're editing, or null if adding

  AddEditCourseScreen({Key? key, this.course}) : super(key: key);

  @override
  _AddEditCourseScreenState createState() => _AddEditCourseScreenState();
}

class _AddEditCourseScreenState extends State<AddEditCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _durationController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.course?.title ?? '');
    _durationController = TextEditingController(text: widget.course?.duration ?? '');
    _descriptionController = TextEditingController(text: widget.course?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveCourse() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save the course to your data storage,
      // and possibly navigate back to the previous screen.
      // For demonstration, we're just closing the screen.
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Add Course' : 'Edit Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Course Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the course duration';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              // You might want to add fields for modules, requirements, etc. similarly
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _saveCourse,
                  child: Text('Save Course'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
