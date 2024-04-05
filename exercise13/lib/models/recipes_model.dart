

import 'dart:convert';

import 'package:exercise13/models/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeModel extends ChangeNotifier {
  List<Recipe> recipes = [];
  List<String> favoriteRecipes = [];
  bool isDarkMode = false; // Default to light mode

  RecipeModel() {
    loadRecipes();
    loadThemePreference();
  }

  void loadRecipes() async {
    String jsonString = await rootBundle.loadString('assets/recipes.json');
    List<dynamic> jsonList = json.decode(jsonString)['recipes'];
    recipes = jsonList.map((json) => Recipe.fromJson(json)).toList();
    notifyListeners();
  }

  void toggleFavorite(String recipeName) {
    if (favoriteRecipes.contains(recipeName)) {
      favoriteRecipes.remove(recipeName);
    } else {
      favoriteRecipes.add(recipeName);
    }
    notifyListeners();
  }

  // Load theme preference from local storage
  void loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    isDarkMode = value;
    notifyListeners();
  }

}