enum TimeFilter { all, today, thisWeek, thisMonth }

class FilterModel {
  final String? category;
  final String? location;
  final TimeFilter timeFilter;
  final double? maxDistance; // in kilometers

  FilterModel({
    this.category,
    this.location,
    this.timeFilter = TimeFilter.all,
    this.maxDistance,
  });

  FilterModel copyWith({
    String? category,
    String? location,
    TimeFilter? timeFilter,
    double? maxDistance,
  }) {
    return FilterModel(
      category: category ?? this.category,
      location: location ?? this.location,
      timeFilter: timeFilter ?? this.timeFilter,
      maxDistance: maxDistance ?? this.maxDistance,
    );
  }

  bool get hasFilters =>
      category != null ||
      location != null ||
      timeFilter != TimeFilter.all ||
      maxDistance != null;

  DateTime? get startDate {
    final now = DateTime.now();
    switch (timeFilter) {
      case TimeFilter.today:
        return DateTime(now.year, now.month, now.day);
      case TimeFilter.thisWeek:
        return now.subtract(Duration(days: now.weekday - 1));
      case TimeFilter.thisMonth:
        return DateTime(now.year, now.month, 1);
      case TimeFilter.all:
        return null;
    }
  }
}
