import 'package:flutter/material.dart';
import '../../screens/item detail/item_detail_screen.dart';
import '../../widgets/lost_found_card.dart';

class MyClaimsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF5F5CF6),
          title: const Text('My Claims'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Accepted'),
                  Tab(text: 'Rejected'),
                  Tab(text: 'Pending'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildClaimsList(),
            _buildClaimsList(),
            _buildClaimsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          LostFoundCard(
            imageUrl: 'assets/macbook.jpg',
            title: 'Macbook',
            category: 'Electronics',
            location: 'CMC, Addis Ababa',
            isLost: true,
          ),
          LostFoundCard(
            imageUrl: 'assets/macbook.jpg',
            title: 'Macbook',
            category: 'Electronics',
            location: 'CMC, Addis Ababa',
            isLost: true,
          ),
        ],
      ),
    );
  }
}
