import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_recipes_model.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'favorites_screen.dart';
import 'recipe_screen.dart';
import 'settings_screen.dart'; // You'll create this for loadRecipes function

class RecipesGridScreen extends StatefulWidget {
  const RecipesGridScreen({super.key});
  @override
  RecipesGridScreenState createState() => RecipesGridScreenState();
}

class RecipesGridScreenState extends State<RecipesGridScreen> {
  Future<List<Recipe>>? _recipesFuture;
  List<Recipe> favoriteRecipes = []; // Initialize favoriteRecipes list
  RecipeService _recipeService = RecipeService();
  @override
  void initState() {
    super.initState();
    _recipesFuture = _recipeService.loadRecipes();
  }

  //updates the state
  void toggleFavorite(Recipe recipe) {
    final model = Provider.of<FavoriteRecipesModel>(context, listen: false);

    if (model.isFavorite(recipe)) {
      model.remove(recipe);
    } else {
      model.add(recipe);
    }

    // Ensure the recipe object in your list is also updated
    recipe.favourite = !recipe.favourite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Exercise Thirteen'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save_alt),
              onPressed: () async {
                // Create an instance of Recipe
                Recipe chocolateCake = Recipe(
                  title: 'Chocolate Cake',
                  author: 'Jane Doe',
                  amount: '5',
                  difficulty: 'Easy',
                  speed: '60 mins',
                  likes: 120,
                  imageUrl: 'https://scientificallysweet.com/wp-content/uploads/2023/06/IMG_4087-er-new1.jpg',
                  favourite: true,
                  description: 'Delicious and rich chocolate cake.',
                  ingredients: ['2 cups sugar', '1 3/4 cups all-purpose flour', '3/4 cup cocoa'],
                  directions: ['Preheat oven to 350 degrees F.', 'Mix dry ingredients.', 'Bake for 35 minutes.'],
                  time: 60,
                );

                // Add the new recipe to the list
                _recipeService.addRecipe(chocolateCake);

                // Save the updated list of recipes to a file
                await _recipeService.saveRecipes();

                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Recipe saved successfully!'),
                    duration: const Duration(seconds: 2),
                  ),
                );

                // Update the UI by setting the state
                setState(() {
                  // Assuming this will trigger a rebuild of the recipes list in the UI
                });
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero, // Remove padding from the ListView.
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Semantics(
                  header: true,
                  child: const Text('Exercise 13'), // Mark it as a header for semantic purposes.
                ),
              ),
              Semantics(
                button: true,
                label: 'Navigate to Recipes Screen',
                child: ListTile(
                  title: const Text('Recipes'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipesGridScreen()));
                  },
                ),
              ),
              Semantics(
                button: true,
                label: 'Navigate to Favourite Recipes Screen',
                child: ListTile(
                  title: const Text('Favourite Recipes'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteRecipes: [],)));
                  },
                ),
              ),
              Semantics(
                button: true,
                label: 'Navigate to Settings Screen',
                child: ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer before navigating.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                ),
              ),
            ],
          ),
        ),

        // Use FutureBuilder to wait for the recipes data to be loaded
        body: FutureBuilder<List<Recipe>>(
          future: _recipesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No recipes found.'));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final recipe = snapshot.data![index];
                  return Semantics(
                    label: 'Recipe card for ${recipe.title}',
                    hint: 'Double tap to open recipe details',
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [

                          Positioned.fill(
                            child: Image.network(
                              recipe.imageUrl,
                              fit: BoxFit.cover,
                              semanticLabel: 'Image of the recipe ${recipe.title}', // Provide a description for screen readers
                            ),
                          ),

                          Positioned.fill(
                            child: Container(
                              height: 180.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), // Dim the image with a semi-transparent overlay
                              ),
                            ),
                          ),

                          Positioned(
                            top: 8.0,
                            left: 8.0,
                            child: Semantics(
                              label: 'Recipe author ${recipe.author}',
                              child: Text(
                                recipe.author,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 35.0,
                            left: 8.0,
                            child: Semantics(
                              label: 'Recipe title ${recipe.title}',
                              child: Text(
                                recipe.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 12.0,
                            right: 0.0,
                            left: 0.0,
                            child: Semantics(
                              label: 'Recipe details: ${recipe.speed} minutes to cook, costs ${recipe.amount}, difficulty rating: ${recipe.difficulty}',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer, color: Colors.white, size: 18.0),
                                  SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      recipe.speed,
                                      style: const TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.attach_money, color: Colors.white, size: 18.0),
                                  SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      recipe.amount,
                                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.star, color: Colors.white, size: 18.0),
                                  SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      recipe.difficulty,
                                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RecipeScreen(recipe: recipe),
                                  ),
                                ),
                                // Providing a semantic label for the entire card
                                child: Semantics(
                                  label: '${recipe.title} by ${recipe.author}. Tap for details.',
                                  excludeSemantics: true, // We're using the parent Semantics instead
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: IconButton(
                              icon: Icon(recipe.favourite ? Icons.favorite : Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () {
                                // Directly call toggleFavorite here
                                setState(() {
                                  toggleFavorite(recipe);
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}
