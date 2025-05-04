import 'package:flutter/material.dart';
import '../services/post_service.dart';

class CreatePostProvider with ChangeNotifier {
  final PostService _postService = PostService();

  String _itemCategory = '';
  String _location = '';
  String _itemName = '';
  String _itemDetails = '';
  String _specialMark = '';
  List<String> _photos = [];
  bool _isSubmitting = false;
  String? _error;

  // Available categories
  final List<String> _availableCategories = [
    'Electronics',
    'Documents',
    'Jewelry',
    'Clothing',
    'Books',
    'Bags',
    'Others',
  ];

  // Getters
  String get itemCategory => _itemCategory;
  String get location => _location;
  String get itemName => _itemName;
  String get itemDetails => _itemDetails;
  String get specialMark => _specialMark;
  List<String> get photos => _photos;
  List<String> get availableCategories => _availableCategories;
  bool get isSubmitting => _isSubmitting;
  String? get error => _error;

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

  void addPhoto(String photoPath) {
    if (_photos.length < 6) {
      _photos.add(photoPath);
      notifyListeners();
    }
  }

  void removePhoto(int index) {
    if (index >= 0 && index < _photos.length) {
      _photos.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> submitPost() async {
    // Validate required fields
    if (_itemCategory.isEmpty ||
        _location.isEmpty ||
        _itemName.isEmpty ||
        _itemDetails.isEmpty) {
      _error = 'Please fill in all required fields';
      notifyListeners();
      return;
    }

    _isSubmitting = true;
    _error = null;
    notifyListeners();

    try {
      await _postService.createPost(
        category: _itemCategory,
        location: _location,
        itemName: _itemName,
        itemDetails: _itemDetails,
        specialMark: _specialMark,
        photos: _photos,
        isFound: true, // Since this is for found items
      );

      // Clear form after successful submission
      _itemCategory = '';
      _location = '';
      _itemName = '';
      _itemDetails = '';
      _specialMark = '';
      _photos = [];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  void clearForm() {
    _itemCategory = '';
    _location = '';
    _itemName = '';
    _itemDetails = '';
    _specialMark = '';
    _photos = [];
    _error = null;
    notifyListeners();
  }
}
