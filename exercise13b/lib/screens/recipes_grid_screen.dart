import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_recipes_model.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'favorites_screen.dart';
import 'new_recipe_screen.dart';
import 'recipe_screen.dart';
import 'settings_screen.dart'; // You'll create this for loadRecipes function

class RecipesGridScreen extends StatefulWidget {
  const RecipesGridScreen({super.key});

  @override
  RecipesGridScreenState createState() => RecipesGridScreenState();
}

class RecipesGridScreenState extends State<RecipesGridScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Recipe>>? _recipesFuture;
  List<Recipe> favoriteRecipes = []; // Initialize favoriteRecipes list
  // @override
  // void initState() {
  //   super.initState();
  //   final recipeService = Provider.of<RecipeService>(context, listen: false);
  //   _recipesFuture = recipeService.loadRecipes(); // Use RecipeService to load recipes
  // }
  @override
  void initState() {
    super.initState();
    _loadRecipes(); // This will call the method to set the _recipesFuture
  }
  void _loadRecipes() {
    final recipeService = Provider.of<RecipeService>(context, listen: false);
    setState(() {
      _recipesFuture = recipeService.loadRecipes();
    });
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

  // When you navigate to RecipeScreen from RecipesGridScreen
  void _navigateAndPossiblyRefresh(BuildContext context, Recipe recipe) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeScreen(recipe: recipe),
      ),
    );

    // If the result is true, refresh your recipes list
    if (result == true) {
      setState(() {
        // Assuming you have a method to reload the recipes
        _recipesFuture = Provider.of<RecipeService>(context, listen: false).loadRecipes();
      });
    }
  }

  // Inside RecipesGridScreenState
  Future<void> _navigateToFavoritesAndRefresh() async {
    // Navigate to the FavouritesScreen
    final deletionHappened = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteRecipes: [])),
    );
    // Close the drawer with Future.microtask to ensure it's executed in the next event loop
    Future.microtask(() => Navigator.of(context).pop());
    // If a deletion occurred, refresh the recipes on the grid screen
    if (deletionHappened == true) {
      setState(() {
        _recipesFuture = Provider.of<RecipeService>(context, listen: false).loadRecipes();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipeService = Provider.of<RecipeService>(context, listen: false);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Exercise Twelve'),
          actions: <Widget>[

            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                // Await the return from NewRecipeScreen
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewRecipeScreen(),
                  ),
                );
                // Once NewRecipeScreen is popped, refresh the list of recipes
                setState(() {
                  // Assuming _recipesFuture is your Future variable for loading recipes
                  _recipesFuture = recipeService.loadRecipes();
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
                  child: const Text('Recipe App'), // Mark it as a header for semantic purposes.
                ),
              ),

              Semantics(
                button: true,
                label: 'Navigate to Recipes Grid Screen',
                child: ListTile(
                  title: const Text('Recipes'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RecipesGridScreen()));
                  },
                ),
              ),

              Semantics(
                button: true,
                label: 'Navigate to Favourite Recipes Screen',
                child: ListTile(
                  title: const Text('Favourite Recipes'),
                  // Inside the onTap callback for the 'Favourite Recipes' ListTile in the drawer
                  onTap: () async {
                    final deletionHappened = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteRecipes: [])),
                    );
                    if (deletionHappened == true) {
                      print('Deletion happened, refreshing recipes list.');
                      _loadRecipes(); // Call this method to refresh the recipes list
                    }
                  },

                  // onTap: () {
                  //   Navigator.pop(context); // Close the drawer before navigating.
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteRecipes: [])));
                  // },
                  // Inside the RecipesGridScreen's Drawer, ListTile for Favourite Recipes
                  // onTap: () async {
                  //   // Navigate to the FavouritesScreen
                  //   final deletionHappened = await Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const FavouritesScreen(favoriteRecipes: [])),
                  //   );
                  //   // If a deletion happened, refresh the grid
                  //   if (deletionHappened == true) {
                  //     _refreshRecipesAfterDeletion();
                  //   }
                  // },
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
                                style: const TextStyle(color: Colors.white),
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
                                  const Icon(Icons.timer, color: Colors.white, size: 18.0),
                                  const SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      recipe.speed,
                                      style: const TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.attach_money, color: Colors.white, size: 18.0),
                                  const SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      recipe.amount,
                                      style: const TextStyle(color: Colors.white, fontSize: 10.0),
                                      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.star, color: Colors.white, size: 18.0),
                                  const SizedBox(width: 1),
                                  Flexible( // Make the text flexible so it fits in the remaining space
                                    child: Text(
                                      recipe.difficulty,
                                      style: const TextStyle(color: Colors.white, fontSize: 10.0),
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

                                onTap: () => _navigateAndPossiblyRefresh(context, recipe),

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
