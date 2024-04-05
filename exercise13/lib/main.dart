import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/favorite_recipes_model.dart';
import 'models/recipes_model.dart';
import 'models/theme_provider.dart';
import 'screens/start_page.dart';
import 'models/theme_provider.dart';

void main() {
  runApp(const RecipesApp());
}
class RecipesApp extends StatelessWidget {
  const RecipesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeModel(),
      child: Consumer<RecipeModel>(
        builder: (context, model, child) {
          return MaterialApp(
            title: 'Recipes App',
            theme: ThemeData.light(), // Default light theme
            darkTheme: ThemeData.dark(), // Default dark theme
            themeMode: model.isDarkMode ? ThemeMode.dark : ThemeMode.light, // Use themeMode based on user preference
            home: const StartUpPage(),
          );
        },
      ),
    );
  }
}
