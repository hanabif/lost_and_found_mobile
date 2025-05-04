import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostService {
  static const String baseUrl =
      'YOUR_API_BASE_URL'; // Replace with your actual API URL

  Future<List<Post>> getRecentPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/recent'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recent posts');
      }
    } catch (e) {
      throw Exception('Error fetching recent posts: $e');
    }
  }

  Future<Post> createPost({
    required String category,
    required String location,
    required String itemName,
    required String itemDetails,
    String? specialMark,
    required List<String> photos,
    required bool isFound,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'category': category,
          'location': location,
          'itemName': itemName,
          'itemDetails': itemDetails,
          'specialMark': specialMark,
          'photos': photos,
          'isFound': isFound,
        }),
      );

      if (response.statusCode == 201) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  Future<List<Post>> searchPosts({
    String? category,
    String? location,
    String? query,
  }) async {
    try {
      final queryParams = {
        if (category != null) 'category': category,
        if (location != null) 'location': location,
        if (query != null) 'query': query,
      };

      final uri = Uri.parse(
        '$baseUrl/posts/search',
      ).replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search posts');
      }
    } catch (e) {
      throw Exception('Error searching posts: $e');
    }
  }

  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Mobile', 'Laptop', 'Document', 'ID', 'Key'];
  }
}
