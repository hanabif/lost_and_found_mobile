import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemService {
  final String baseUrl = 'http://your-node-js-backend-url'; // Replace with your actual backend URL

  Future<void> createPost({
    required String category,
    required String location,
    required String name,
    required String details,
    required String specialMark,
  }) async {
    final url = Uri.parse('$baseUrl/items'); // Replace '/items' with your actual endpoint

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'category': category,
        'location': location,
        'name': name,
        'details': details,
        'specialMark': specialMark,
      }),
    );

    if (response.statusCode != 201) { // Assuming 201 Created for success
      print('Failed to create item: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to create item');
    }
  }
}
