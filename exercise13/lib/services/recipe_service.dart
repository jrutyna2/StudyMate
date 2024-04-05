import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '/models/recipe.dart';

class RecipeService {
  List<Recipe> _recipes = [];

  Future<List<Recipe>> loadRecipes() async {
    // Check if the recipes have already been loaded to avoid unnecessary work
    if (_recipes.isNotEmpty) return _recipes;

    String jsonString = await rootBundle.loadString('assets/recipe_list.json');
    final jsonResponse = jsonDecode(jsonString);
    _recipes = List<Recipe>.from(jsonResponse['recipes'].map((model) => Recipe.fromJson(model)));
    return _recipes;
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  Future<File> saveRecipes() async {
    final directory = await getApplicationDocumentsDirectory();
    print('Directory path: ${directory.path}');
    final file = File('${directory.path}/recipes_updated.json');
    String jsonString = jsonEncode(_recipes.map((recipe) => recipe.toJson()).toList());
    return file.writeAsString(jsonString);
  }
}
