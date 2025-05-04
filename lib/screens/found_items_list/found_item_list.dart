import 'package:flutter/material.dart';
import '../../widgets/lost_found_card.dart';
import '../item detail/item_detail_screen.dart';

class FoundItemsPage extends StatelessWidget {
  const FoundItemsPage({super.key});

  static const Color primaryColor = Color(0xFF525FE1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text("Lost Items", style: TextStyle(color: Colors.white)),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                "Piassa, A.A",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
          Icon(Icons.location_on_outlined, color: Colors.white),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search your lost items",
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                suffixIcon: const Icon(Icons.filter_list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          // Items Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                bool isLost = index % 2 == 0;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailsScreen(),
                      ),
                    );
                  },
                  child: LostFoundCard(
                    title: isLost ? "Macbook" : "Key with rings",
                    category: isLost ? "Electronics" : "Keys",
                    location: "CMC, Addis Ababa",
                    imageUrl: isLost ? "assets/macbook.jpg" : "assets/keys.jpg",
                    isLost: isLost,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
