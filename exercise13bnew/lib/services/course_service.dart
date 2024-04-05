import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/course.dart'; // Updated import to use Course model

class CourseService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    // Updated file name to reflect courses
    return File('$path/course_list.json');
  }

  Future<File> writeCourses(String courses) async {
    final file = await _localFile;
    return file.writeAsString(courses);
  }

  Future<String> readCourses() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return a default JSON structure for courses
      return '{"courses": []}';
    }
  }

  /// Initializes app data by copying courses from assets to the local directory if not already present.
  Future<void> initCourses() async {
    final file = await _localFile;
    bool fileExists = await file.exists();
    if (!fileExists) {
      // Ensure to replace 'recipe_list.json' with your 'course_list.json' in your assets
      String courses = await rootBundle.loadString('assets/course_list.json');
      await writeCourses(courses);
    }
  }

  /// Loads the current list of courses from the local file, reflecting any user modifications (additions, deletions, or changes).
  Future<List<Course>> loadCourses() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      final jsonResponse = jsonDecode(contents);
      List<Course> courses = List<Course>.from(jsonResponse['courses'].map((model) => Course.fromJson(model)));
      return courses;
    } catch (e) {
      return [];
    }
  }

  Future<void> addCourse(Course course) async {
    final List<Course> courses = await loadCourses();
    // Check for duplicate course based on a unique attribute (e.g., id)
    bool isDuplicate = courses.any((c) => c.id == course.id);
    if (!isDuplicate) {
      courses.add(course);
      String coursesJson = jsonEncode({'courses': courses.map((c) => c.toJson()).toList()});
      await writeCourses(coursesJson);
    } else {
      // Handle the duplicate case, e.g., by throwing an exception or returning a status
      throw Exception("Course already exists.");
    }
  }

  Future<void> deleteCourse(String id) async {
    final List<Course> courses = await loadCourses();
    final updatedCourses = courses.where((course) => course.id != id).toList();
    final String coursesJson = jsonEncode({'courses': updatedCourses.map((c) => c.toJson()).toList()});
    await writeCourses(coursesJson);
  }

// Add your other functions related to courses like loadCourses, saveCourses, etc.
}
