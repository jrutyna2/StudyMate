import 'package:flutter/material.dart';
import '../models/course.dart'; // Make sure to import the Course model
//FavoriteCoursesModel serves as global state that holds the list of favorite courses.
//the notifyListeners method in ChangeNotifier tells listening widgets to rebuild.
class FavoriteCoursesModel extends ChangeNotifier {
  List<Course> _favoriteCourses = [];
  List<Course> get favoriteCourses => _favoriteCourses;

  // void loadFavorites(List<Course> courses) {
  //   _favoriteCourses = courses.where((course) => course.favourite).toList();
  //   notifyListeners();
  // }

  // This updated method ensures no duplicates are added to the favorites list.
  void setFavorites(List<Course> courses) {
    // Clear the current list of favorite courses.
    _favoriteCourses.clear();
    // Add each course, ensuring no duplicates.
    for (var course in courses) {
      if (!_favoriteCourses.any((r) => r.title == course.title)) {
        _favoriteCourses.add(course);
      }
    }
    // Notify all listening widgets that the model has updated.
    notifyListeners();
  }

  void add(Course course) {
    if (!_favoriteCourses.any((r) => r.title == course.title)) {
      _favoriteCourses.add(course);
      notifyListeners();
    }
  }

  // void add(Course course) {
  //   if (!_favoriteCourses.contains(course)) {
  //     _favoriteCourses.add(course);
  //     notifyListeners();
  //   }
  // }

  void remove(Course course) {
    _favoriteCourses.removeWhere((r) => r.title == course.title);
    notifyListeners();
  }

  bool isFavorite(Course course) => _favoriteCourses.contains(course);
}