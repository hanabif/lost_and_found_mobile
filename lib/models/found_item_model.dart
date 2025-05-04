class FoundItem {
  final String id;
  final String title;
  final String category;
  final String location;
  final String imageUrl;
  final String description;
  final DateTime foundDate;
  final String? contactInfo;
  final List<String>? tags;

  FoundItem({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.foundDate,
    this.contactInfo,
    this.tags,
  });

  factory FoundItem.fromJson(Map<String, dynamic> json) {
    return FoundItem(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      foundDate: DateTime.parse(json['foundDate'] as String),
      contactInfo: json['contactInfo'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'imageUrl': imageUrl,
      'description': description,
      'foundDate': foundDate.toIso8601String(),
      'contactInfo': contactInfo,
      'tags': tags,
    };
  }
} 