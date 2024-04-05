import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '/models/course.dart';

class CourseService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/course_list.json');
  }

  Future<File> writeCourses(String recipes) async {
    final file = await _localFile;
    return file.writeAsString(recipes);
  }

  Future<String> readCourses() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return a default JSON structure
      return '{"recipes": []}';
    }
  }

  /// Initializes app data by copying recipes from assets to the local directory if not already present.
  Future<void> initCourses() async { // It's intended to run once during the app startup.
    final file = await _localFile;
    bool fileExists = await file.exists();
    if (!fileExists) {
      String recipes = await rootBundle.loadString('assets/course_list.json');
      await writeCourses(recipes);
    }
  }

  /// Loads the current list of recipes from the local file, reflecting any user modifications(additions, deletions, or changes).
  Future<List<Course>> loadCourses() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      final jsonResponse = jsonDecode(contents);
      List<Course> recipes = List<Course>.from(jsonResponse['recipes'].map((model) => Course.fromJson(model)));
      return recipes;
    } catch (e) {
      return [];
    }
  }

  Future<void> addCourse(Course recipe) async {
    final List<Course> recipes = await loadCourses();
    // Check for duplicate recipe based on a unique attribute (e.g., title)
    bool isDuplicate = recipes.any((r) => r.title == recipe.title);
    if (!isDuplicate) {
      recipes.add(recipe);
      String recipesJson = jsonEncode({'recipes': recipes.map((r) => r.toJson()).toList()});
      await writeCourses(recipesJson);
    } else {
      // Handle the duplicate case, e.g., by throwing an exception or returning a status
      throw Exception("Course already exists.");
    }
  }

  Future<void> deleteCourse(String title) async {
    final List<Course> recipes = await loadCourses();
    final updatedCourses = recipes.where((recipe) => recipe.title != title).toList();
    final String recipesJson = jsonEncode({'recipes': updatedCourses.map((r) => r.toJson()).toList()});
    await writeCourses(recipesJson);
  }

// Add your other functions related to recipes like loadCourses, saveCourses, etc.
}