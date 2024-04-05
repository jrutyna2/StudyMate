import 'package:flutter/material.dart';
import 'course.dart'; // Make sure to import the Recipe model
//FavoriteRecipesModel serves as global state that holds the list of favorite recipes.
//the notifyListeners method in ChangeNotifier tells listening widgets to rebuild.
class FavoriteRecipesModel extends ChangeNotifier {
  List<Recipe> _favoriteRecipes = [];
  List<Recipe> get favoriteRecipes => _favoriteRecipes;

  // void loadFavorites(List<Recipe> recipes) {
  //   _favoriteRecipes = recipes.where((recipe) => recipe.favourite).toList();
  //   notifyListeners();
  // }

  // This updated method ensures no duplicates are added to the favorites list.
  void setFavorites(List<Recipe> recipes) {
    // Clear the current list of favorite recipes.
    _favoriteRecipes.clear();
    // Add each recipe, ensuring no duplicates.
    for (var recipe in recipes) {
      if (!_favoriteRecipes.any((r) => r.title == recipe.title)) {
        _favoriteRecipes.add(recipe);
      }
    }
    // Notify all listening widgets that the model has updated.
    notifyListeners();
  }

  void add(Recipe recipe) {
    if (!_favoriteRecipes.any((r) => r.title == recipe.title)) {
      _favoriteRecipes.add(recipe);
      notifyListeners();
    }
  }

  // void add(Recipe recipe) {
  //   if (!_favoriteRecipes.contains(recipe)) {
  //     _favoriteRecipes.add(recipe);
  //     notifyListeners();
  //   }
  // }

  void remove(Recipe recipe) {
    _favoriteRecipes.removeWhere((r) => r.title == recipe.title);
    notifyListeners();
  }

  bool isFavorite(Recipe recipe) => _favoriteRecipes.contains(recipe);
}