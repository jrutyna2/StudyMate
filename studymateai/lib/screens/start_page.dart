import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_recipes_model.dart';
import '/models/recipe.dart';
import '/services/recipe_service.dart';
import 'recipes_grid_screen.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({super.key});

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;
  List<Recipe> _recipes = []; //
  RecipeService? recipeService;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _positionAnimation = Tween(begin: const Offset(0, 0.25), end: Offset.zero).animate(_controller!);

    _controller!.forward();

    // Load recipes and update favorites after build
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAndSetFavorites());
    // Correctly load the recipes using RecipeService from the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipeService = Provider.of<RecipeService>(context, listen: false);
      recipeService.loadRecipes().then((loadedRecipes) {
        if (mounted) {
          setState(() {
            _recipes = loadedRecipes;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadAndSetFavorites() async {
    // Here, we can access the Provider context safely
    final recipeService = Provider.of<RecipeService>(context, listen: false);
    List<Recipe> recipes = await recipeService.loadRecipes();
    final favoritesModel = Provider.of<FavoriteRecipesModel>(context, listen: false);
    // Assume FavoriteRecipesModel has a method to set favorites from loaded recipes
    favoritesModel.setFavorites(recipes.where((recipe) => recipe.favourite).toList());
  }

  void _onSignIn() {
    _controller!.reverse().then((value) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RecipesGridScreen()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _opacityAnimation!,
        child: SlideTransition(
          position: _positionAnimation!,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Recipe App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSignIn,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // foreground
                  ),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
