// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/providers/claim_provider.dart';
import 'package:provider/provider.dart';


class ClaimItemScreen extends StatefulWidget {
  const ClaimItemScreen({Key? key}) : super(key: key);

  @override
  State<ClaimItemScreen> createState() => _ClaimItemScreenState();
}

class _ClaimItemScreenState extends State<ClaimItemScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClaimProvider>(context);
    const primaryColor = Color(0xFF3F51B5);
     // Default Material Blue for AppBar and button

    return Scaffold(
      appBar: AppBar(
        title: const Text('Claim Item'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // Fullname
            TextField(
              decoration: InputDecoration(
                hintText: 'Fullname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
               onChanged: provider.setFullname,
            ),
            const SizedBox(height: 16),

            // Mobile number
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '(+251) Enter mobile number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              
              onChanged: provider.setMobileNumber,
            ),
            const SizedBox(height: 16),

            // Date input
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'When did you lose it? (DD/MM/YYYY)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                prefixIcon: const Icon(Icons.calendar_today_outlined),
              ),
              onChanged: provider.setLostDate,
            ),
            const SizedBox(height: 16),

            // Where exactly did you lose it?
            TextField(
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Where exactly did you lose it?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              onChanged: provider.setLostLocation,
            ),
            const SizedBox(height: 16),

            // Was there anything inside or attached to the item?
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Was there anything inside or attached to the item? (E.g., contents of a bag, keychains on keys, stickers on a laptop, etc.)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              onChanged: provider.setAttachedDetails,
            ),
            const SizedBox(height: 16),

            // Proof of ownership (optional upload)
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Proof of ownership (optional upload) (Photo of the item if available, purchase receipt, serial number, etc.)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              onChanged: provider.setProofOfOwnership,
            ),
            const SizedBox(height: 16),

            // Checkbox with label
            Row(
              children: [
                Checkbox(
                  value: provider.confirmInfo,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'I confirm that the information provided is true and accurate',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Submit Claim button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: provider.confirmInfo
                    ? () async {
                        try {
                          await provider.submitClaim();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Claim submitted successfully!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to submit claim: $e')),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  disabledBackgroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit Claim',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
