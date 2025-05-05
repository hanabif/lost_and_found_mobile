// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import '../../widgets/lost_found_card.dart';
// import '../../providers/home_provider.dart';
// import '../../models/post_model.dart';
// import 'filter_modal.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   static const Color primaryColor = Color(0xFF525FE1);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Load data when the screen is first created
//     Future.microtask(() => context.read<HomeProvider>().loadData());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lost & Found'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 builder: (context) => const FilterModal(),
//               );
//             },
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: Consumer<HomeProvider>(
//         builder: (context, provider, child) {
//           final filteredPosts = provider.filteredPosts;

//           if (filteredPosts.isEmpty) {
//             return const Center(child: Text('No posts found'));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: filteredPosts.length,
//             itemBuilder: (context, index) {
//               final post = filteredPosts[index];
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (post.photos.isNotEmpty)
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(8),
//                         ),
//                         child: Image.network(
//                           post.photos.first,
//                           height: 200,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             post.itemName,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             post.itemDetails,
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               const Icon(Icons.category_outlined, size: 16),
//                               const SizedBox(width: 4),
//                               Text(
//                                 post.category,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                               const SizedBox(width: 16),
//                               const Icon(Icons.location_on_outlined, size: 16),
//                               const SizedBox(width: 4),
//                               Text(
//                                 post.location,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               const Icon(Icons.access_time, size: 16),
//                               const SizedBox(width: 4),
//                               Text(
//                                 'Posted ${provider.getTimeAgo(post.createdAt)}',
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // 👤 Main header widget (kept private to this file)
// class _MainHeader extends StatelessWidget {
//   final String userName;
//   final String location;

//   const _MainHeader({required this.userName, required this.location});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: HomeScreen.primaryColor,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Profile Info
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 20,
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.person, color: Colors.grey),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     userName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         location,
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       const Icon(
//                         Icons.verified,
//                         color: Colors.white70,
//                         size: 14,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           // Notification Icon
//           IconButton(
//             icon: const Icon(Icons.notifications_none, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 🔍 Search bar widget
// class _SearchBarSection extends StatelessWidget {
//   const _SearchBarSection();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Row(
//           children: [
//             Icon(Icons.search, color: HomeScreen.primaryColor, size: 24),
//             const SizedBox(width: 8),
//             const Expanded(
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search your lost items',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.filter_list, color: Colors.black),
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(24),
//                     ),
//                   ),
//                   builder: (context) => const FilterModal(),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // 📦 Grid of categories
// class _CategoryGridSection extends StatelessWidget {
//   final List<String> categories;

//   const _CategoryGridSection({required this.categories});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Create post by category',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           GridView.count(
//             crossAxisCount: 3,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.8,
//             children:
//                 categories.map((category) {
//                   final iconPath = '${category.toLowerCase()}.png';
//                   return _CategoryCard(label: category, iconPath: iconPath);
//                 }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 📁 Individual category card
// class _CategoryCard extends StatelessWidget {
//   final String label;
//   final String iconPath;

//   const _CategoryCard({required this.label, required this.iconPath});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFFDF7F4),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset('assets/icons/$iconPath', height: 40, width: 40),
//           const SizedBox(height: 10),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 🕐 Recent posts section
// class _RecentPostsSection extends StatelessWidget {
//   final List<Post> posts;

//   const _RecentPostsSection({required this.posts});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Recent posts',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: 190,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 return Padding(
//                   padding: EdgeInsets.only(
//                     right: index < posts.length - 1 ? 12 : 0,
//                   ),
//                   child: LostFoundCard(
//                     imageUrl: post.photos.isNotEmpty ? post.photos.first : '',
//                     title: post.itemName,
//                     category: post.category,
//                     location: post.location,
//                     isLost: !post.isFound,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lost_and_found_mobile/providers/home_provider.dart';
import 'package:lost_and_found_mobile/widgets/lost_found_card.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Fetch posts and location when screen loads
    Future.microtask(() => context.read<HomeProvider>().loadData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getCategoryAsset(String category) {
    switch (category.toLowerCase()) {
      case 'mobile':
        return 'assets/icons/Mobile.svg';
      case 'electronics':
        return 'assets/icons/electronics.svg';
      case 'documents':
        return 'assets/icons/documents.svg';
      case 'cards':
        return 'assets/icons/cards.svg';
      case 'keys':
        return 'assets/icons/keys.svg';
      default:
        return 'assets/icons/category.svg';
    }
  }

  void _onBottomNavTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        // Already on HomeScreen, do nothing or maybe scroll to top
        break;
      case 1:
        Navigator.pushNamed(context, '/create_post');
        break;
      case 2:
        Navigator.pushNamed(context, '/my_cases');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F5BD5),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          icon: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              'assets/icons/profile.svg',
              height: 24,
              width: 24,
              color: Colors.grey[700],
            ),
          ),
        ),
        title: const Text(
          'Millium Bengit',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/megaphone.svg',
              height: 24,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }
          final posts = provider.filteredPosts;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search your lost item...',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        height: 20,
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    provider.setSearchQuery(value);
                    provider.search();
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'Create post by category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: provider.categories
                        .map((category) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  provider.setFilter(
                                    provider.currentFilter.copyWith(category: category),
                                  );
                                },
                                child: _CategoryCard(
                                  assetPath: _getCategoryAsset(category),
                                  label: category,
                                  isSelected: provider.currentFilter.category == category,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Recent posts',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: posts.isEmpty
                      ? const Center(child: Text('No posts found'))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: LostFoundCard(
                                imageUrl: post.photos.isNotEmpty
                                    ? post.photos.first
                                    : 'assets/images/placeholder.png',
                                title: post.itemName,
                                category: post.category,
                                location: post.location,
                                isLost: !post.isFound,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF4F5BD5),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 24,
              color: _currentIndex == 0 ? const Color(0xFF4F5BD5) : Colors.grey,
            ),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: const Color(0xFF4F5BD5),
              child: SvgPicture.asset(
                'assets/icons/add circle.svg',
                height: 24,
                color: Colors.white,
              ),
            ),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              height: 24,
              color: _currentIndex == 2 ? const Color(0xFF4F5BD5) : Colors.grey,
            ),
            label: 'My Cases',
          ),
        ],
        onTap: _onBottomNavTap,
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String assetPath;
  final String label;
  final bool isSelected;
  const _CategoryCard({
    required this.assetPath,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4F5BD5).withOpacity(0.15) : Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xFF4F5BD5) : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath,
            height: 32,
            color: const Color(0xFF4F5BD5),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

