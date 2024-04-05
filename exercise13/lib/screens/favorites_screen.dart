import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../models/favorite_recipes_model.dart';
import '../services/recipe_service.dart';
import 'recipe_screen.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Recipe> favoriteRecipes;

  const FavouritesScreen({super.key, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    // Assuming FavoriteRecipesModel is provided higher in the widget tree with ChangeNotifierProvider
    final favoriteRecipes = Provider.of<FavoriteRecipesModel>(context).favoriteRecipes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return Semantics(
            label: 'Recipe ${recipe.title} by ${recipe.author}',
            hint: 'Double tap to view recipe details',
            child: Card(
              child: ListTile(
                leading: ExcludeSemantics(
                  child: Image.network(
                    recipe.imageUrl,
                    fit: BoxFit.cover,
                    width: 100.0,
                    semanticLabel: 'Image of the recipe ${recipe.title}', // Provide a description of the image for screen readers
                  ),
                ),
                title: Text(recipe.title), // Display the recipe title
                subtitle: Text(recipe.author), // Display the recipe author
                onTap: () {
                  // Provide navigation to detailed screen if needed
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeScreen(recipe: recipe)));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}