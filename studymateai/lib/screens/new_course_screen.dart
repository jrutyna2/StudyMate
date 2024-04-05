import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_course_model.dart';
import '../models/course.dart'; // Make sure this import points to where your Course model is defined
import '../services/course_service.dart';

class NewCourseScreen extends StatefulWidget {
  const NewCourseScreen({super.key});

  @override
  NewCourseScreenState createState() => NewCourseScreenState();
}

class NewCourseScreenState extends State<NewCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  // final _titleController = TextEditingController();
  // final _authorController = TextEditingController();
  // final _amountController = TextEditingController();
  // final _difficultyController = TextEditingController();
  // final _cookingTimeController = TextEditingController();
  // final _likesController = TextEditingController();
  // final _imageUrlController = TextEditingController();
  // bool _isFavourite = false;
  // final _descriptionController = TextEditingController();
  // final _ingredientsController = TextEditingController();
  // final _directionsController = TextEditingController();
  // final _cookTimeController = TextEditingController();

  final _titleController = TextEditingController(text: 'Chocolate Cake');
  final _authorController = TextEditingController(text: 'Jane Doe');
  final _amountController = TextEditingController(text: '5');
  final _difficultyController = TextEditingController(text: 'Easy');
  final _cookingTimeController = TextEditingController(text: '60 mins');
  final _likesController = TextEditingController(text: '120');
  final _imageUrlController = TextEditingController(text: 'https://scientificallysweet.com/wp-content/uploads/2023/06/IMG_4087-er-new1.jpg');
  bool _isFavourite = true; // Directly set the boolean value for favorite status
  final _descriptionController = TextEditingController(text: 'Delicious and rich chocolate cake.');
  // Since ingredients and directions are lists, join them into a string for the TextEditingController
  final _ingredientsController = TextEditingController(text: '2 cups sugar, 1 3/4 cups all-purpose flour, 3/4 cup cocoa');
  final _directionsController = TextEditingController(text: 'Preheat oven to 350 degrees F., Mix dry ingredients., Bake for 35 minutes.');
  final _cookTimeController = TextEditingController(text: '60');

  void _saveCourse() {
    final recipeService = Provider.of<CourseService>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      final newCourse = Course(
        title: _titleController.text,
        author: _authorController.text,
        amount: _amountController.text,
        difficulty: _difficultyController.text,
        speed: _cookingTimeController.text,
        likes: int.tryParse(_likesController.text) ?? 0,
        imageUrl: _imageUrlController.text,
        favourite: _isFavourite,
        description: _descriptionController.text,
        ingredients: _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
        directions: _directionsController.text.split(',').map((e) => e.trim()).toList(),
        time: int.tryParse(_cookTimeController.text) ?? 0,
      );

      recipeService.addCourse(newCourse).then((_) {
        // If the recipe is marked as favorite, add it to the favorites model as well.
        if (newCourse.favourite) {
          final favoritesModel = Provider.of<FavoriteCoursesModel>(context, listen: false);
          favoritesModel.add(newCourse);
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
                TextFormField(controller: _authorController, decoration: const InputDecoration(labelText: 'Author')),
                TextFormField(controller: _amountController, decoration: const InputDecoration(labelText: 'Amount of Ingredients')),
                TextFormField(controller: _difficultyController, decoration: const InputDecoration(labelText: 'Difficulty')),
                TextFormField(controller: _cookingTimeController, decoration: const InputDecoration(labelText: 'Cooking Time')),
                TextFormField(controller: _likesController, decoration: const InputDecoration(labelText: 'Likes'), keyboardType: TextInputType.number),
                TextFormField(controller: _imageUrlController, decoration: const InputDecoration(labelText: 'Image URL')),
                SwitchListTile(
                  title: const Text('Is Favourite'),
                  value: _isFavourite,
                  onChanged: (bool value) {
                    setState(() {
                      _isFavourite = value;
                    });
                  },
                ),
                TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
                TextFormField(controller: _ingredientsController, decoration: const InputDecoration(labelText: 'Ingredients (comma separated)')),
                TextFormField(controller: _directionsController, decoration: const InputDecoration(labelText: 'Directions (comma separated)')),
                TextFormField(controller: _cookTimeController, decoration: const InputDecoration(labelText: 'Cook Time'), keyboardType: TextInputType.number),
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
    // Dispose controllers when the widget is removed from the widget tree
    _titleController.dispose();
    _authorController.dispose();
    _amountController.dispose();
    _difficultyController.dispose();
    _cookingTimeController.dispose();
    _likesController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _directionsController.dispose();
    _cookTimeController.dispose();
    super.dispose();
  }
}
