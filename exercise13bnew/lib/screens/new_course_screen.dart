import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_courses_model.dart';
import '../models/course.dart'; // Updated import for Course model
import '../services/course_service.dart';

class NewCourseScreen extends StatefulWidget {
  const NewCourseScreen({super.key});

  @override
  NewCourseScreenState createState() => NewCourseScreenState();
}

class NewCourseScreenState extends State<NewCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  // Updated TextEditingController instances for course-specific attributes
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _difficultyController = TextEditingController();
  final _likesController = TextEditingController();
  final _imageUrlController = TextEditingController();
  bool _isFavorite = false;
  final _descriptionController = TextEditingController();
  final _modulesController = TextEditingController();
  final _materialsController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _categoriesController = TextEditingController();

  void _saveCourse() {
    final courseService = Provider.of<CourseService>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      // Create a new Course object from the form data
      final newCourse = Course(
        id: DateTime.now().toString(), // Generating a simple unique ID for the example
        title: _titleController.text,
        duration: _durationController.text,
        difficulty: _difficultyController.text,
        likes: int.tryParse(_likesController.text) ?? 0,
        imageUrl: _imageUrlController.text,
        isFavorite: _isFavorite,
        description: _descriptionController.text,
        modules: _modulesController.text.split(',').map((e) => e.trim()).toList(),
        materials: _materialsController.text.split(',').map((e) => e.trim()).toList(),
        requirements: _requirementsController.text.split(',').map((e) => e.trim()).toList(),
        categories: _categoriesController.text.split(',').map((e) => e.trim()).toList(),
      );

      courseService.addCourse(newCourse).then((_) {
        // If the course is marked as favorite, add it to the favorites model as well.
        if (newCourse.isFavorite) {
          final favoritesModel = Provider.of<FavoriteCoursesModel>(context, listen: false);
          favoritesModel.addFavorite(newCourse);
        }
        Navigator.pop(context); // Go back to the previous screen after saving
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Course"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
                TextFormField(controller: _durationController, decoration: const InputDecoration(labelText: 'Duration')),
                TextFormField(controller: _difficultyController, decoration: const InputDecoration(labelText: 'Difficulty')),
                TextFormField(controller: _likesController, decoration: const InputDecoration(labelText: 'Likes'), keyboardType: TextInputType.number),
                TextFormField(controller: _imageUrlController, decoration: const InputDecoration(labelText: 'Image URL')),
                SwitchListTile(
                  title: const Text('Is Favorite'),
                  value: _isFavorite,
                  onChanged: (bool value) {
                    setState(() {
                      _isFavorite = value;
                    });
                  },
                ),
                TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
                TextFormField(controller: _modulesController, decoration: const InputDecoration(labelText: 'Modules (comma separated)')),
                TextFormField(controller: _materialsController, decoration: const InputDecoration(labelText: 'Materials (comma separated)')),
                TextFormField(controller: _requirementsController, decoration: const InputDecoration(labelText: 'Requirements (comma separated)')),
                TextFormField(controller: _categoriesController, decoration: const InputDecoration(labelText: 'Categories (comma separated)')),
                ElevatedButton(
                  onPressed: _saveCourse,
                  child: const Text('Save Course'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    _titleController.dispose();
    _durationController.dispose();
    _difficultyController.dispose();
    _likesController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    _modulesController.dispose();
    _materialsController.dispose();
    _requirementsController.dispose();
    _categoriesController.dispose();
    super.dispose();
  }
}
