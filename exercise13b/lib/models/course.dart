class Recipe {
  final String title;
  final String author;
  final String amount;
  final String difficulty;
  final String speed;
  final int likes;
  final String imageUrl;
  bool favourite;
  final String description;
  final List<String> ingredients;
  final List<String> directions;
  final int time;

  Recipe({
    required this.title,
    required this.author,
    required this.amount,
    required this.difficulty,
    required this.speed,
    required this.likes,
    required this.imageUrl,
    required this.favourite,
    required this.description,
    required this.ingredients,
    required this.directions,
    required this.time,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['recipeName'] as String,
      author: json['recipeAuthor'] as String,
      amount: json['amountOfIngredients'] as String,
      difficulty: json['recipeDifficulty'] as String,
      speed: json['cookingTime'] as String,
      likes: json['totalLikes'] as int,
      imageUrl: json['imageUrl'] as String,
      favourite: json['isFavourite'] as bool,
      description: json['description'] as String, //List<String>.from(json['description']),
      ingredients: List<String>.from(json['ingredients']),
      directions: List<String>.from(json['directions']),
      time: json['cookTime'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeName': title,
      'recipeAuthor': author,
      'amountOfIngredients': amount,
      'recipeDifficulty': difficulty,
      'cookingTime': speed,
      'totalLikes': likes,
      'imageUrl': imageUrl,
      'isFavourite': favourite,
      'description': description, // If description is a List<String>, convert it using `description.toList()`
      'ingredients': ingredients.toList(),
      'directions': directions.toList(),
      'cookTime': time,
    };
  }
}