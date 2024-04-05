class CourseTemplate {
  String id;
  String imageUrl;
  String title;
  String description;
  double rating;
  String content; // Added content field

  CourseTemplate({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
    this.content = '', // Default to an empty string if not specified
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'title': title,
    'description': description,
    'rating': rating,
    'content': content, // Include content in serialization
  };

  factory CourseTemplate.fromJson(Map<String, dynamic> json) => CourseTemplate(
    id: json['id'],
    imageUrl: json['imageUrl'],
    title: json['title'],
    description: json['description'],
    rating: json['rating'],
    content: json['content'] ?? '', // Safely handle null with a default empty string
  );
}
