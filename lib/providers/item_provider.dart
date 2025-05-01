import 'package:flutter/foundation.dart';
import '../models/item.dart';
import '../services/item_service.dart';

/// Provides lost/found items and search‐filter logic to the UI.
class ItemProvider extends ChangeNotifier {
  final ItemService _service;

  ItemProvider({ItemService? service})
      : _service = service ?? ItemService();

  bool _isLoading = false;
  String _searchQuery = '';
  List<Item> _allItems = [];

  /// Whether a fetch is in progress.
  bool get isLoading => _isLoading;

  /// Returns only those items matching “lost” status and the current search query.
  List<Item> get filteredLostItems {
    var list =
        _allItems.where((i) => i.isLost).toList(); // assuming Item has isLost
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list
          .where((i) =>
              i.title.toLowerCase().contains(q) ||
              i.locationTag.toLowerCase().contains(q))
          .toList();
    }
    return list;
  }

  /// Fetches lost items from your backend and updates listeners.
  Future<void> fetchLostItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Replace with actual API call
      _allItems = await _service.fetchLostItems();
    } catch (e) {
      // TODO: handle / log errors
      if (kDebugMode) print('Error fetching lost items: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates the search query and rebuilds the filtered list.
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
