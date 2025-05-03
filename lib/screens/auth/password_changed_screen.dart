import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Changed UI',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Or use custom color scheme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PasswordChangedScreen(),
    );
  }
}

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or your desired background color
      body: SafeArea(
        // Ensures content is not obscured by notches, status bars, etc.
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ), // Add horizontal padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center horizontally
              children: <Widget>[
                // Title Text
                const Text(
                  'Password changed',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Adjust color as needed
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16.0,
                ), // Spacing between title and subtitle
                // Subtitle Text
                const Text(
                  'Your password has been changed successfully',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54, // Adjust color as needed
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40.0,
                ), // Spacing between subtitle and button
                // Back to Login Button
                SizedBox(
                  // To control the button's width
                  width:
                      double
                          .infinity, // Make button take full available width within padding
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5C6EF8), // Button background color (adjust as needed)
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ), // Button corner radius
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Back to login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
