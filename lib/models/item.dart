class Item {
  final String id;
  final String imageUrl;      // URL of the item image
  final String title;         // e.g. "Wallet"
  final String category;      // e.g. "Wallet", "Phone"
  final String locationTag;   // e.g. "Library"
  final DateTime postedAt;    // Timestamp when item was posted
  final bool isLost;          // true => lost report, false => found report

  Item({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.locationTag,
    required this.postedAt,
    required this.isLost,
  });

  /// Creates an [Item] from a JSON map (e.g. from REST or Firestore).
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      locationTag: json['locationTag'] as String,
      postedAt: DateTime.parse(json['postedAt'] as String),
      isLost: json['isLost'] as bool,
    );
  }

  String? get name => null;

  get location => null;

  get dateLost => null;

  get timeLost => null;

  /// Converts this [Item] into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'category': category,
      'locationTag': locationTag,
      'postedAt': postedAt.toIso8601String(),
      'isLost': isLost,
    };
  }
}