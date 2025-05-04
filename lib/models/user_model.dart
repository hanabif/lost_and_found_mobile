class User {
  final String id;
  final String email;
  final String fullName;
  final String? profilePicture;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    this.profilePicture,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      profilePicture: json['profilePicture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
