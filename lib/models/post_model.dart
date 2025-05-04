class Post {
  final String id;
  final String category;
  final String location;
  final double latitude;
  final double longitude;
  final String itemName;
  final String itemDetails;
  final String? specialMark;
  final List<String> photos;
  final DateTime createdAt;
  final String userId;
  final bool isFound; // true for found items, false for lost items

  Post({
    required this.id,
    required this.category,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.itemName,
    required this.itemDetails,
    this.specialMark,
    required this.photos,
    required this.createdAt,
    required this.userId,
    required this.isFound,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      itemName: json['itemName'] as String,
      itemDetails: json['itemDetails'] as String,
      specialMark: json['specialMark'] as String?,
      photos: List<String>.from(json['photos'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
      isFound: json['isFound'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'itemName': itemName,
      'itemDetails': itemDetails,
      'specialMark': specialMark,
      'photos': photos,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'isFound': isFound,
    };
  }
}
