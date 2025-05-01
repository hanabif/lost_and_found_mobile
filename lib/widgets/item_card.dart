// import 'package:flutter/material.dart';

// /// Badges to indicate whether this card is for a lost or found item.
// enum BadgeType { lost, found }

// /// A card that displays an item’s photo, title, category, location, time ago, and a small badge.
// class ItemCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String category;
//   final String location;
//   final DateTime timestamp;
//   final BadgeType badge;
//   final VoidCallback? onTap;

//   const ItemCard({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.category,
//     required this.location,
//     required this.timestamp,
//     this.badge = BadgeType.found,
//     this.onTap, required item,
//   });

//   String _timeAgo() {
//     final diff = DateTime.now().difference(timestamp);
//     if (diff.inMinutes < 60) {
//       return '${diff.inMinutes}m ago';
//     } else if (diff.inHours < 24) {
//       return '${diff.inHours}h ago';
//     } else {
//       return '${diff.inDays}d ago';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final badgeColor = badge == BadgeType.lost
//         ? Colors.redAccent
//         : Colors.green;
//     final badgeText = badge == BadgeType.lost ? 'Lost' : 'Found';

//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         clipBehavior: Clip.antiAlias,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image with badge overlay
//             Stack(
//               children: [
//                 AspectRatio(
//                   aspectRatio: 4 / 3,
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) =>
//                         Center(child: Icon(Icons.broken_image)),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: badgeColor.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       badgeText,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Padding for text content
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style:
//                           const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 4),
//                   Text(category,
//                       style: const TextStyle(
//                           fontSize: 14, color: Colors.grey)),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on, size: 14),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(location,
//                             style: const TextStyle(fontSize: 12)),
//                       ),
//                       Text(_timeAgo(),
//                           style: const TextStyle(
//                               fontSize: 12, color: Colors.grey)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/models/item.dart';


class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            item.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'Unknown Item',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('Lost at ${item.location}'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('Lost on ${item.dateLost}'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('Around ${item.timeLost}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}