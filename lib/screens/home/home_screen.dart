import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../widgets/lost_found_card.dart';
import '../../providers/home_provider.dart';
import '../../models/post_model.dart';
import 'filter_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xFF525FE1);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when the screen is first created
    Future.microtask(() => context.read<HomeProvider>().loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => context.read<HomeProvider>().refreshData(),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.recentPosts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null && provider.recentPosts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${provider.error}'),
                    ElevatedButton(
                      onPressed: () => provider.loadData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _MainHeader(
                      userName: 'Millium Ben', location: 'Piassa, A.A'),
                  const SizedBox(height: 16),
                  const _SearchBarSection(),
                  const SizedBox(height: 24),
                  _CategoryGridSection(categories: provider.categories),
                  const SizedBox(height: 24),
                  _RecentPostsSection(posts: provider.recentPosts),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// 👤 Main header widget (kept private to this file)
class _MainHeader extends StatelessWidget {
  final String userName;
  final String location;

  const _MainHeader({required this.userName, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HomeScreen.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Info
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        color: Colors.white70,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Notification Icon
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// 🔍 Search bar widget
class _SearchBarSection extends StatelessWidget {
  const _SearchBarSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: HomeScreen.primaryColor, size: 24),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your lost items',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (context) => const FilterModal(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 📦 Grid of categories
class _CategoryGridSection extends StatelessWidget {
  final List<String> categories;

  const _CategoryGridSection({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create post by category',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
            children: categories.map((category) {
              final iconPath = '${category.toLowerCase()}.png';
              return _CategoryCard(
                label: category,
                iconPath: iconPath,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// 📁 Individual category card
class _CategoryCard extends StatelessWidget {
  final String label;
  final String iconPath;

  const _CategoryCard({required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDF7F4),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/$iconPath',
            height: 40,
            width: 40,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// 🕐 Recent posts section
class _RecentPostsSection extends StatelessWidget {
  final List<Post> posts;

  const _RecentPostsSection({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent posts',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Padding(
                  padding:
                      EdgeInsets.only(right: index < posts.length - 1 ? 12 : 0),
                  child: LostFoundCard(
                    imageUrl: post.imageUrl,
                    title: post.title,
                    category: post.category,
                    location: post.location,
                    isLost: post.isLost,
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
