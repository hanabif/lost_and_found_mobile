import 'dart:io';
import '../models/found_item_model.dart';

class FoundItemService {
  // Simulated API calls with mock data
  Future<FoundItem> createFoundItem({
    required String title,
    required String category,
    required String location,
    required String description,
    required File image,
    String? contactInfo,
    List<String>? tags,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, this would upload the image and create the item in the backend
    return FoundItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: category,
      location: location,
      imageUrl:
          'assets/images/placeholder.png', // In real app, this would be the uploaded image URL
      description: description,
      foundDate: DateTime.now(),
      contactInfo: contactInfo,
      tags: tags,
    );
  }

  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Mobile', 'Electronics', 'Documents', 'Cards', 'Keys'];
  }

  Future<List<String>> getLocations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Mexico Square', '4 Kilo', 'Piassa', 'Saris', 'Bole'];
  }
}
