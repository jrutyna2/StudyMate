import 'package:flutter/material.dart';
import 'recipe.dart'; // Make sure to import the Recipe model
//FavoriteRecipesModel serves as global state that holds the list of favorite recipes.
//the notifyListeners method in ChangeNotifier tells listening widgets to rebuild.
class FavoriteRecipesModel extends ChangeNotifier {
  final List<Recipe> _favoriteRecipes = [];

  List<Recipe> get favoriteRecipes => _favoriteRecipes;

  void add(Recipe recipe) {
    if (!_favoriteRecipes.contains(recipe)) {
      _favoriteRecipes.add(recipe);
      notifyListeners();
    }
  }

  void remove(Recipe recipe) {
    if (_favoriteRecipes.contains(recipe)) {
      _favoriteRecipes.remove(recipe);
      notifyListeners();
    }
  }

  bool isFavorite(Recipe recipe) => _favoriteRecipes.contains(recipe);
}