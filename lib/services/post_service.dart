import '../models/post_model.dart';

class PostService {
  // Simulated API calls with mock data
  Future<List<Post>> getRecentPosts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      Post(
        id: '1',
        title: 'Macbook Air M2',
        category: 'Electronics',
        location: 'Mexico Square',
        imageUrl: 'assets/images/Frame 18.png',
        isLost: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Post(
        id: '2',
        title: 'Key with 3 rings',
        category: 'Keys',
        location: '4 Kilo',
        imageUrl: 'assets/images/Frame 18 (1).png',
        isLost: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];
  }

  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Mobile', 'Laptop', 'Document', 'ID', 'Key'];
  }
}
