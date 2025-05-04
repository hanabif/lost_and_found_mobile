import 'package:flutter/foundation.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

class HomeProvider with ChangeNotifier {
  final PostService _postService = PostService();

  List<Post> _recentPosts = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get recentPosts => _recentPosts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final posts = await _postService.getRecentPosts();
      final categories = await _postService.getCategories();

      _recentPosts = posts;
      _categories = categories;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await loadData();
  }
}
