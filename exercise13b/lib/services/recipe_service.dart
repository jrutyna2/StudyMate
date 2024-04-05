import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:exercise12/models/recipe.dart';

class RecipeService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/recipe_list.json');
  }

  Future<File> writeRecipes(String recipes) async {
    final file = await _localFile;
    return file.writeAsString(recipes);
  }

  Future<String> readRecipes() async {
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
  Future<void> initRecipes() async { // It's intended to run once during the app startup.
    final file = await _localFile;
    bool fileExists = await file.exists();
    if (!fileExists) {
      String recipes = await rootBundle.loadString('assets/recipe_list.json');
      await writeRecipes(recipes);
    }
  }

  /// Loads the current list of recipes from the local file, reflecting any user modifications(additions, deletions, or changes).
  Future<List<Recipe>> loadRecipes() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      final jsonResponse = jsonDecode(contents);
      List<Recipe> recipes = List<Recipe>.from(jsonResponse['recipes'].map((model) => Recipe.fromJson(model)));
      return recipes;
    } catch (e) {
      return [];
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    final List<Recipe> recipes = await loadRecipes();
    // Check for duplicate recipe based on a unique attribute (e.g., title)
    bool isDuplicate = recipes.any((r) => r.title == recipe.title);
    if (!isDuplicate) {
      recipes.add(recipe);
      String recipesJson = jsonEncode({'recipes': recipes.map((r) => r.toJson()).toList()});
      await writeRecipes(recipesJson);
    } else {
      // Handle the duplicate case, e.g., by throwing an exception or returning a status
      throw Exception("Recipe already exists.");
    }
  }

  Future<void> deleteRecipe(String title) async {
    final List<Recipe> recipes = await loadRecipes();
    final updatedRecipes = recipes.where((recipe) => recipe.title != title).toList();
    final String recipesJson = jsonEncode({'recipes': updatedRecipes.map((r) => r.toJson()).toList()});
    await writeRecipes(recipesJson);
  }

// Add your other functions related to recipes like loadRecipes, saveRecipes, etc.
}