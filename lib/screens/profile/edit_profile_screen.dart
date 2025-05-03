import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController(text: 'Puerto Rico');
  final TextEditingController emailController = TextEditingController(text: 'youremail@domain.com');
  String selectedCountry = 'United States';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(92, 110, 248, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name
            const Text("Full name"),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your full name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Email
            const Text("Email"),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Phone Number
            const Text("Phone number"),
            const SizedBox(height: 8),
            IntlPhoneField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              initialCountryCode: 'US',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
            const SizedBox(height: 20),

            // Country Dropdown
            const Text("Country"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCountry,
              items: const [
                DropdownMenuItem(value: 'United States', child: Text('United States')),
                DropdownMenuItem(value: 'Canada', child: Text('Canada')),
                DropdownMenuItem(value: 'United Kingdom', child: Text('United Kingdom')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCountry = value;
                  });
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),

            const Spacer(),

            // Done Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C6EF8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
