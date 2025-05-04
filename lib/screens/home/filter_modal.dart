import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import '../../models/filter_model.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key}) : super(key: key);

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late String? selectedCategory;
  late String? selectedLocation;
  late TimeFilter selectedTimeFilter;
  late double? selectedDistance;
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentFilter = context.read<HomeProvider>().currentFilter;
    selectedCategory = currentFilter.category;
    selectedLocation = currentFilter.location;
    selectedTimeFilter = currentFilter.timeFilter;
    selectedDistance = currentFilter.maxDistance;
    _locationController.text = selectedLocation ?? '';
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final filter = FilterModel(
      category: selectedCategory,
      location: selectedLocation,
      timeFilter: selectedTimeFilter,
      maxDistance: selectedDistance,
    );
    context.read<HomeProvider>().setFilter(filter);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    const primaryColor = Color(0xFF4F5BD5);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Posts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Category Filter
          const Text(
            'Category',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ...provider.categories.map((category) {
                final isSelected = category == selectedCategory;
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = selected ? category : null;
                    });
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: primaryColor.withOpacity(0.2),
                  checkmarkColor: primaryColor,
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          // Location Filter
          const Text(
            'Location',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: 'Enter location',
              prefixIcon: const Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedLocation = value.isEmpty ? null : value;
              });
            },
          ),
          const SizedBox(height: 16),
          // Time Filter
          const Text(
            'Time Posted',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ...TimeFilter.values.map((timeFilter) {
                final isSelected = timeFilter == selectedTimeFilter;
                return FilterChip(
                  label: Text(_getTimeFilterLabel(timeFilter)),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedTimeFilter = timeFilter;
                    });
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: primaryColor.withOpacity(0.2),
                  checkmarkColor: primaryColor,
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          // Distance Filter
          const Text(
            'Maximum Distance',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ...provider.distanceOptions.map((distance) {
                final isSelected = distance == selectedDistance;
                return FilterChip(
                  label: Text('${distance.toInt()} km'),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedDistance = selected ? distance : null;
                    });
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: primaryColor.withOpacity(0.2),
                  checkmarkColor: primaryColor,
                );
              }),
            ],
          ),
          const SizedBox(height: 24),
          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _applyFilters,
              child: const Text(
                'Apply Filters',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeFilterLabel(TimeFilter filter) {
    switch (filter) {
      case TimeFilter.all:
        return 'All Time';
      case TimeFilter.today:
        return 'Today';
      case TimeFilter.thisWeek:
        return 'This Week';
      case TimeFilter.thisMonth:
        return 'This Month';
    }
  }
}
