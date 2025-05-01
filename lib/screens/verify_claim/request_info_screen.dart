// import 'package:flutter/material.dart';
// import 'package:lost_and_found_mobile/providers/claim_provider.dart';
// import 'package:provider/provider.dart';

// import 'package:lost_and_found_mobile/widgets/item_card.dart'; // Assuming this exists or will be created

// class ClaimInfoScreen extends StatefulWidget {
//   static const routeName = '/claim-info';

//   const ClaimInfoScreen({super.key});

//   @override
//   State<ClaimInfoScreen> createState() => _ClaimInfoScreenState();
// }

// class _ClaimInfoScreenState extends State<ClaimInfoScreen> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final claimId = ModalRoute.of(context)!.settings.arguments as String;
//     Provider.of<ClaimProvider>(context, listen: false).fetchClaim(claimId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Claim Info'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: Colors.purple, // Matches Figma design
//       ),
//       body: Consumer<ClaimProvider>(
//         builder: (context, claimProvider, child) {
//           if (claimProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (claimProvider.error != null) {
//             return Center(child: Text('Error: ${claimProvider.error}'));
//           } else if (claimProvider.currentClaim == null) {
//             return const Center(child: Text('No claim found'));
//           } else {
//             final claim = claimProvider.currentClaim!;
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Item Details Card
//                   ItemCard(item: claim.item), // Reuse or customize as needed
//                   const SizedBox(height: 16),
//                   // Claimant Info Section
//                   _buildSection(
//                     title: 'Claimant Info',
//                     icon: Icons.person,
//                     children: [
//                       _buildDetailRow(Icons.person, 'Full Name: ${claim.claimantName}'),
//                       _buildDetailRow(Icons.phone, 'Phone Number: ${claim.claimantPhone}'),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Loss Details Section
//                   _buildSection(
//                     title: 'When did you lose it?',
//                     icon: Icons.calendar_today,
//                     children: [
//                       Text(claim.lossDescription),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Additional Details Section
//                   _buildSection(
//                     title: 'Additional Details',
//                     icon: Icons.info,
//                     children: [
//                       Text(claim.additionalDetails),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Proof of Ownership Section
//                   _buildSection(
//                     title: 'Proof of Ownership',
//                     icon: Icons.receipt,
//                     children: [
//                       claim.proofImage != null
//                           ? Image.network(
//                               claim.proofImage!,
//                               height: 200,
//                               fit: BoxFit.cover,
//                             )
//                           : const Text('No proof provided'),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   // Action Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           await claimProvider.declineClaim();
//                           if (context.mounted) Navigator.of(context).pop();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         ),
//                         child: const Text('Decline'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           await claimProvider.approveClaim();
//                           if (context.mounted) Navigator.of(context).pop();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         ),
//                         child: const Text('Approve'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           await claimProvider.requestMoreInfo();
//                           if (context.mounted) Navigator.of(context).pop();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.purple,
//                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         ),
//                         child: const Text('Request more info'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildSection({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, size: 20, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: Colors.grey),
//           const SizedBox(width: 8),
//           Expanded(child: Text(text)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/providers/claim_provider.dart';
import 'package:provider/provider.dart';

class RequestMoreInfoScreen extends StatefulWidget {
  const RequestMoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<RequestMoreInfoScreen> createState() => _RequestMoreInfoScreenState();
}

class _RequestMoreInfoScreenState extends State<RequestMoreInfoScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<String> _questions = [];

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  void _addQuestion() {
    final question = _questionController.text.trim();
    if (question.isNotEmpty) {
      setState(() {
        _questions.add(question);
        _questionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestInfoProvider = Provider.of<RequestInfoProvider>(context);
    const primaryColor = Color(0xFF4F5BD5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request more info'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                hintText: 'Eg. What is serial number?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Add question button
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _addQuestion,
                  icon: const Icon(Icons.add),
                  label: const Text('Add question'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Display list of added questions
            if (_questions.isNotEmpty) ...[
              const Text(
                'Your questions:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    final question = _questions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(question),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              _questions.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
