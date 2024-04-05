import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'course_template.dart'; // Update this path

class CourseManager {
  Future<void> addCourse(CourseTemplate course) async {
    final prefs = await SharedPreferences.getInstance();

    final String? coursesJson = prefs.getString('courses');
    final List<CourseTemplate> courses = coursesJson != null ?
    List<CourseTemplate>.from(json.decode(coursesJson).map((x) => CourseTemplate.fromJson(x))) :
    [];

    courses.add(course);

    await prefs.setString('courses', json.encode(courses.map((x) => x.toJson()).toList()));
  }

  Future<List<CourseTemplate>> getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? coursesJson = prefs.getString('courses');

    if (coursesJson != null) {
      final List<CourseTemplate> courses = List<CourseTemplate>.from(json.decode(coursesJson).map((x) => CourseTemplate.fromJson(x)));
      return courses;
    }
    return [];
  }
}
