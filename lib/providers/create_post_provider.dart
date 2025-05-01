import 'package:flutter/material.dart';
import '../services/item_service.dart'; // Import service

class CreatePostProvider extends ChangeNotifier {
  String _itemCategory = '';
  String _location = '';
  String _itemName = '';
  String _itemDetails = '';
  String _specialMark = '';

  // Getters
  String get itemCategory => _itemCategory;
  String get location => _location;
  String get itemName => _itemName;
  String get itemDetails => _itemDetails;
  String get specialMark => _specialMark;

  // Setters
  void setItemCategory(String value) {
    _itemCategory = value;
    notifyListeners();
  }

  void setLocation(String value) {
    _location = value;
    notifyListeners();
  }

  void setItemName(String value) {
    _itemName = value;
    notifyListeners();
  }

  void setItemDetails(String value) {
    _itemDetails = value;
    notifyListeners();
  }

  void setSpecialMark(String value) {
    _specialMark = value;
    notifyListeners();
  }

  // New method to call the service
  Future<void> submitPost() async {
    try {
      // Call the item service to create the post
      await ItemService().createPost(
        category: _itemCategory,
        location: _location,
        name: _itemName,
        details: _itemDetails,
        specialMark: _specialMark,
      );

      // Optionally clear the form after successful submission
      clear();
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print('Error submitting post: $e');
      rethrow; // Re-throw to handle in UI layer if needed
    }
  }

  // Optional: Clear all fields (for reset)
  void clear() {
    _itemCategory = '';
    _location = '';
    _itemName = '';
    _itemDetails = '';
    _specialMark = '';
    notifyListeners();
  }
}
