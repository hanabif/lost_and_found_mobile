import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/providers/claim_provider.dart';
import 'package:provider/provider.dart';

class ClaimInfoScreen extends StatelessWidget {
  const ClaimInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final claimInfoProvider = Provider.of<ClaimInfoProvider>(context);
    const primaryColor = Color(0xFF4F5BD5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Claim Info',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Card
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Container(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item Image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=400&q=80',
                          height: 90,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Macbook',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Electronics',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'ID: 12345, Added: 23 May 2019',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Claim Info Details
            const Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(child: Icon(Icons.person, size: 18)),
                  TextSpan(text: '  Full Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Helen Tamirat\n'),
                  WidgetSpan(child: Icon(Icons.phone, size: 18)),
                  TextSpan(text: '  Phone Number: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '+251954839146\n'),
                  TextSpan(text: '\nWhere did you lose it?\n', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Near the main library entrance, next to the benches\n'),
                  TextSpan(text: '\nWhen did you lose it?\n', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '23/05/2017 around 3 PM\n'),
                  WidgetSpan(child: Icon(Icons.search, size: 18)),
                  TextSpan(text: '  Hidden details:\n', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Small scratch on the back side, and a blue cat sticker inside.\n'),
                ],
              ),
              style: TextStyle(fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 16),

            // Proof of Ownership
            const Text(
              'Proof of Ownership:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Example image, replace with actual image in real app
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=300&q=80',
                    height: 70,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Decline', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Approve', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Request more info button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primaryColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Request more info',
                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
