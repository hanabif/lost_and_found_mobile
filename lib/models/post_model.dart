class Post {
  final String id;
  final String title;
  final String category;
  final String location;
  final String imageUrl;
  final bool isLost;
  final String? description;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.imageUrl,
    required this.isLost,
    this.description,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      isLost: json['isLost'] as bool,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'imageUrl': imageUrl,
      'isLost': isLost,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 