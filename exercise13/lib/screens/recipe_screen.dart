// show rootBundle;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_recipes_model.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe; // Assuming you have a Recipe class.
  const RecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(recipe.title), // Title in the navigation bar
            pinned: true, // Pin the navigation bar
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              minHeight: 200.0, // The minimum height when scrolled up
              maxHeight: 200.0, // The maximum height before scrolling
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ), // The image
            ),
            pinned: true, // Pin the image
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Author: ${recipe.author}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Description: ${recipe.description}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ingredients:",
                      style: TextStyle(
                        fontSize: 18.0, // Choose an appropriate font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: recipe.ingredients.asMap().entries.map((entry) {
                        int index = entry.key + 1; // Adding 1 because list is zero-based
                        String ingredient = entry.value;
                        return Chip(
                          label: Text('$index. $ingredient'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              // For Cooking Time
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Semantics(
                  label: 'Cooking Time',
                  child: Row(
                    children: [
                      const Text(
                        "Time to Cook: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${recipe.time} mins',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // For Directions
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Semantics(
                  label: 'Cooking Directions',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Directions:',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      ...recipe.directions.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        String direction = entry.value;
                        return Semantics(
                          label: 'Step $index',
                          child: Text(
                            '$index. $direction',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}