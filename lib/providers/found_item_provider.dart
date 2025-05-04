import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/found_item_model.dart';
import '../services/found_item_service.dart';

class FoundItemProvider with ChangeNotifier {
  final FoundItemService _foundItemService = FoundItemService();

  // Form state
  String _title = '';
  String _category = '';
  String _location = '';
  String _description = '';
  File? _image;
  String? _contactInfo;
  List<String> _tags = [];

  // Loading and error states
  bool _isLoading = false;
  String? _error;
  bool _isSuccess = false;

  // Lists
  List<String> _categories = [];
  List<String> _locations = [];

  // Getters
  String get title => _title;
  String get category => _category;
  String get location => _location;
  String get description => _description;
  File? get image => _image;
  String? get contactInfo => _contactInfo;
  List<String> get tags => _tags;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSuccess => _isSuccess;
  List<String> get categories => _categories;
  List<String> get locations => _locations;

  // Setters
  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _category = value;
    notifyListeners();
  }

  void setLocation(String value) {
    _location = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void setImage(File value) {
    _image = value;
    notifyListeners();
  }

  void setContactInfo(String value) {
    _contactInfo = value;
    notifyListeners();
  }

  void addTag(String tag) {
    if (!_tags.contains(tag)) {
      _tags.add(tag);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    _tags.remove(tag);
    notifyListeners();
  }

  // Load initial data
  Future<void> loadInitialData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final categories = await _foundItemService.getCategories();
      final locations = await _foundItemService.getLocations();

      _categories = categories;
      _locations = locations;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Submit found item
  Future<void> submitFoundItem() async {
    if (_image == null) {
      _error = 'Please select an image';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    _isSuccess = false;
    notifyListeners();

    try {
      await _foundItemService.createFoundItem(
        title: _title,
        category: _category,
        location: _location,
        description: _description,
        image: _image!,
        contactInfo: _contactInfo,
        tags: _tags,
      );

      _isSuccess = true;
      _resetForm();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset form
  void _resetForm() {
    _title = '';
    _category = '';
    _location = '';
    _description = '';
    _image = null;
    _contactInfo = null;
    _tags = [];
    notifyListeners();
  }
}
