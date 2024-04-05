// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'models/favorite_recipes_model.dart';
// import 'models/recipe.dart';
import 'models/recipe.dart';
import 'screens/start_page.dart';
import 'services/recipe_service.dart';

void main() async {
  // Ensure that Flutter has initialized the framework
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  print("Application Documents Directory: ${directory.path}");

  // Create an instance of RecipeService and initialize recipes
  final recipeService = RecipeService();
  await recipeService.initRecipes();

  // Now, load the recipes and update the favorite recipes model
  List<Recipe> recipes = await recipeService.loadRecipes();

  // Then run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteRecipesModel()),
        Provider(create: (context) => recipeService), // Provide RecipeService here
      ],
      child: MaterialApp(
        title: 'Exercise Twelve',
        theme: ThemeData(
          // Define your app theme here
        ),
        home: StartUpPage(), // Removed the recipeService parameter
      ),
    ),
  );
}

// void demonstrateRecipeSerialization() {
//   // Step 1: Create an instance of Recipe
//   Recipe chocolateCake = Recipe(
//     title: 'Chocolate Cake',
//     author: 'Jane Doe',
//     amount: '5',
//     difficulty: 'Easy',
//     speed: '60 mins',
//     likes: 120,
//     imageUrl: 'https://example.com/cake.jpg',
//     favourite: true,
//     description: 'Delicious and rich chocolate cake.',
//     ingredients: ['2 cups sugar', '1 3/4 cups all-purpose flour', '3/4 cup cocoa'],
//     directions: ['Preheat oven to 350 degrees F.', 'Mix dry ingredients.', 'Bake for 35 minutes.'],
//     time: 60,
//   );
//
//   // Step 2: Convert to JSON
//   String jsonRecipe = jsonEncode(chocolateCake.toJson());
//
//   // Step 3: Print the JSON string
//   print('Serialized Recipe to JSON: $jsonRecipe');
//
//   // Step 4: Parse from JSON
//   Map<String, dynamic> recipeMap = jsonDecode(jsonRecipe);
//   Recipe newRecipe = Recipe.fromJson(recipeMap);
//
//   // Step 5: Print the properties of the new Recipe object
//   print('Deserialized Recipe from JSON:');
//   print('Title: ${newRecipe.title}');
//   print('Author: ${newRecipe.author}');
// }