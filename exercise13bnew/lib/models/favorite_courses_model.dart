import 'package:flutter/material.dart';
import 'course.dart'; // Updated import to use Course model

// FavoriteCoursesModel serves as global state that holds the list of favorite and enrolled courses.
// The notifyListeners method in ChangeNotifier tells listening widgets to rebuild.
class FavoriteCoursesModel extends ChangeNotifier {
  List<Course> _favoriteCourses = [];
  List<Course> _enrolledCourses = [];

  List<Course> get favoriteCourses => _favoriteCourses;
  List<Course> get enrolledCourses => _enrolledCourses;

  // Adds a course to the list of favorite courses, ensuring no duplicates are added.
  void addFavorite(Course course) {
    if (!_favoriteCourses.any((c) => c.id == course.id)) {
      _favoriteCourses.add(course);
      notifyListeners();
    }
  }

  // Removes a course from the list of favorite courses.
  void removeFavorite(Course course) {
    _favoriteCourses.removeWhere((c) => c.id == course.id);
    notifyListeners();
  }

  // Checks if a course is marked as favorite.
  bool isFavorite(Course course) => _favoriteCourses.contains(course);

  // Adds a course to the list of enrolled courses, ensuring no duplicates.
  void enroll(Course course) {
    if (!_enrolledCourses.any((c) => c.id == course.id)) {
      _enrolledCourses.add(course);
      // Optionally mark as favorite when enrolling.
      addFavorite(course);
      notifyListeners();
    }
  }

  // Removes a course from the list of enrolled courses.
  void unenroll(Course course) {
    _enrolledCourses.removeWhere((c) => c.id == course.id);
    notifyListeners();
  }

  // Checks if a user is enrolled in a course.
  bool isEnrolled(Course course) => _enrolledCourses.contains(course);
}
