class Course {
  final String id;
  final String title;
  final String duration;
  final String difficulty;
  final int likes;
  final String imageUrl;
  bool isFavorite; // Indicates if the course is marked as favorite by the user
  bool isEnrolled; // Indicates if the user is enrolled in the course
  final String description;
  final List<String> modules;
  final List<String> materials;
  final List<String> requirements;
  final List<String> categories;

  Course({
    required this.id,
    required this.title,
    required this.duration,
    required this.difficulty,
    required this.likes,
    required this.imageUrl,
    this.isFavorite = false,
    this.isEnrolled = false, // Default is not enrolled
    required this.description,
    required this.modules,
    required this.materials,
    required this.requirements,
    required this.categories,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      duration: json['duration'] as String,
      difficulty: json['difficulty'] as String,
      likes: json['likes'] as int,
      imageUrl: json['imageUrl'] as String,
      isFavorite: json['isFavorite'] as bool,
      isEnrolled: json['isEnrolled'] ?? false, // Assume not enrolled if attribute is missing
      description: json['description'] as String,
      modules: List<String>.from(json['modules']),
      materials: List<String>.from(json['materials']),
      requirements: List<String>.from(json['requirements']),
      categories: List<String>.from(json['categories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'difficulty': difficulty,
      'likes': likes,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'isEnrolled': isEnrolled,
      'description': description,
      'modules': modules.toList(),
      'materials': materials.toList(),
      'requirements': requirements.toList(),
      'categories': categories.toList(),
    };
  }
}
