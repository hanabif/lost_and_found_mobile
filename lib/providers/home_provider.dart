import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../models/post_model.dart';
import '../models/filter_model.dart';
import '../services/post_service.dart';
import '../services/location_service.dart';

class HomeProvider with ChangeNotifier {
  final PostService _postService = PostService();
  final LocationService _locationService = LocationService();

  List<Post> _recentPosts = [];
  List<Post> _searchResults = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  Position? _currentLocation;
  FilterModel _currentFilter = FilterModel();

  // Getters
  List<Post> get recentPosts => _recentPosts;
  List<Post> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  Position? get currentLocation => _currentLocation;
  FilterModel get currentFilter => _currentFilter;

  final List<String> categories = [
    'Electronics',
    'Mobile',
    'Documents',
    'Cards',
    'Keys',
    'Other',
  ];

  final List<double> distanceOptions = [5.0, 10.0, 20.0, 50.0]; // in kilometers

  List<Post> get filteredPosts {
    var filtered = List<Post>.from(_recentPosts);

    // Apply category filter
    if (_currentFilter.category != null) {
      filtered =
          filtered
              .where((post) => post.category == _currentFilter.category)
              .toList();
    }

    // Apply location filter
    if (_currentFilter.location != null) {
      filtered =
          filtered
              .where(
                (post) => post.location.toLowerCase().contains(
                  _currentFilter.location!.toLowerCase(),
                ),
              )
              .toList();
    }

    // Apply time filter
    final now = DateTime.now();
    switch (_currentFilter.timeFilter) {
      case TimeFilter.today:
        filtered =
            filtered
                .where(
                  (post) => post.createdAt.isAfter(
                    now.subtract(const Duration(days: 1)),
                  ),
                )
                .toList();
        break;
      case TimeFilter.thisWeek:
        filtered =
            filtered
                .where(
                  (post) => post.createdAt.isAfter(
                    now.subtract(const Duration(days: 7)),
                  ),
                )
                .toList();
        break;
      case TimeFilter.thisMonth:
        filtered =
            filtered
                .where(
                  (post) => post.createdAt.isAfter(
                    now.subtract(const Duration(days: 30)),
                  ),
                )
                .toList();
        break;
      case TimeFilter.all:
        break;
    }

    // Apply distance filter
    if (_currentFilter.maxDistance != null) {
      // TODO: Implement distance-based filtering when location services are added
    }

    return filtered;
  }

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get current location
      _currentLocation = await _locationService.getCurrentLocation();

      // Get posts
      _recentPosts = await _postService.getRecentPosts();

      // Apply filters and sort
      _applyFilters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _applyFilters() {
    if (_currentLocation == null) return;

    // Filter posts
    var filteredPosts =
        _recentPosts.where((post) {
          // Category filter
          if (_currentFilter.category != null &&
              post.category != _currentFilter.category) {
            return false;
          }

          // Location filter
          if (_currentFilter.location != null &&
              !post.location.toLowerCase().contains(
                _currentFilter.location!.toLowerCase(),
              )) {
            return false;
          }

          // Time filter
          if (_currentFilter.startDate != null &&
              post.createdAt.isBefore(_currentFilter.startDate!)) {
            return false;
          }

          // Distance filter
          if (_currentFilter.maxDistance != null) {
            final distance = _locationService.calculateDistance(
              _currentLocation!.latitude,
              _currentLocation!.longitude,
              post.latitude,
              post.longitude,
            );
            if (distance > _currentFilter.maxDistance!) {
              return false;
            }
          }

          return true;
        }).toList();

    // Sort by distance
    filteredPosts.sort((a, b) {
      final distanceA = _locationService.calculateDistance(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        a.latitude,
        a.longitude,
      );
      final distanceB = _locationService.calculateDistance(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        b.latitude,
        b.longitude,
      );
      return distanceA.compareTo(distanceB);
    });

    _recentPosts = filteredPosts;
  }

  void setFilter(FilterModel filter) {
    _currentFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> search() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _searchResults = await _postService.searchPosts(
        category: _currentFilter.category,
        location: _currentFilter.location,
        query: _searchQuery,
      );

      // Apply filters to search results
      if (_currentLocation != null) {
        _searchResults =
            _searchResults.where((post) {
              // Time filter
              if (_currentFilter.startDate != null &&
                  post.createdAt.isBefore(_currentFilter.startDate!)) {
                return false;
              }

              // Distance filter
              if (_currentFilter.maxDistance != null) {
                final distance = _locationService.calculateDistance(
                  _currentLocation!.latitude,
                  _currentLocation!.longitude,
                  post.latitude,
                  post.longitude,
                );
                if (distance > _currentFilter.maxDistance!) {
                  return false;
                }
              }

              return true;
            }).toList();

        // Sort by distance
        _searchResults.sort((a, b) {
          final distanceA = _locationService.calculateDistance(
            _currentLocation!.latitude,
            _currentLocation!.longitude,
            a.latitude,
            a.longitude,
          );
          final distanceB = _locationService.calculateDistance(
            _currentLocation!.latitude,
            _currentLocation!.longitude,
            b.latitude,
            b.longitude,
          );
          return distanceA.compareTo(distanceB);
        });
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearFilters() {
    _currentFilter = FilterModel();
    _searchQuery = '';
    _applyFilters();
    notifyListeners();
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}
