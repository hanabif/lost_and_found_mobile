// // lib/models/claim.dart

// class Claim {
//   final String id;
//   final String itemId;
//   final String claimantId;
//   final Map<String, dynamic> hiddenDetails; // your verification fields
//   final String? proofUrl;                   // URL to photo/receipt proof
//   final String status;                      // e.g. "pending", "approved", "rejected"
//   final DateTime createdAt;                 // timestamp of submission

//   Claim({
//     required this.id,
//     required this.itemId,
//     required this.claimantId,
//     required this.hiddenDetails,
//     this.proofUrl,
//     required this.status,
//     required this.createdAt,
//   });

//   factory Claim.fromJson(Map<String, dynamic> json) {
//     return Claim(
//       id: json['id'] as String,
//       itemId: json['itemId'] as String,
//       claimantId: json['claimantId'] as String,
//       hiddenDetails: Map<String, dynamic>.from(json['hiddenDetails'] ?? {}),
//       proofUrl: json['proofUrl'] as String?,
//       status: json['status'] as String,
//       createdAt: DateTime.parse(json['createdAt'] as String),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'itemId': itemId,
//       'claimantId': claimantId,
//       'hiddenDetails': hiddenDetails,
//       if (proofUrl != null) 'proofUrl': proofUrl,
//       'status': status,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }
// lib/models/claim.dart
import 'package:lost_and_found_mobile/models/item.dart';

class Claim {
  final String id;
  final Item item;
  final String claimantName;
  final String claimantPhone;
  final String lossDescription;
  final String additionalDetails;
  final String? proofImage;
  late final String status; // Stays final

  Claim({
    required this.id,
    required this.item,
    required this.claimantName,
    required this.claimantPhone,
    required this.lossDescription,
    required this.additionalDetails,
    this.proofImage,
    required this.status,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      id: json['id'],
      item: Item.fromJson(json['item']),
      claimantName: json['claimantName'],
      claimantPhone: json['claimantPhone'],
      lossDescription: json['lossDescription'],
      additionalDetails: json['additionalDetails'],
      proofImage: json['proofImage'],
      status: json['status'] ?? 'pending',
    );
  }
}