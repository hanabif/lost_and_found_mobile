import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import providers
import 'package:lost_and_found_mobile/providers/create_post_provider.dart';
import 'package:lost_and_found_mobile/providers/claim_provider.dart';
import 'package:lost_and_found_mobile/providers/home_provider.dart';
import 'package:lost_and_found_mobile/providers/auth_provider.dart';

// Import screens
import 'package:lost_and_found_mobile/screens/post_found_item/post_found_item_screen.dart'; // CreatePostScreen
import 'package:lost_and_found_mobile/screens/claim_item/claim_item_screen.dart';
import 'package:lost_and_found_mobile/screens/verify_claim/verify_claim_screen.dart'; // ClaimInfoScreen
import 'package:lost_and_found_mobile/screens/verify_claim/request_info_screen.dart'; // RequestMoreInfoScreen
import 'package:lost_and_found_mobile/screens/auth/signup_screen.dart';
import 'package:lost_and_found_mobile/screens/auth/login_screen.dart';
import 'package:lost_and_found_mobile/screens/auth/password_changed_screen.dart';
import 'package:lost_and_found_mobile/screens/home/home_screen.dart';


void main() {
  runApp(const LostNFoundApp());
}


class LostNFoundApp extends StatelessWidget {
  const LostNFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CreatePostProvider()),
        ChangeNotifierProvider(create: (_) => ClaimProvider()),
        ChangeNotifierProvider(create: (_) => ClaimInfoProvider()),
        ChangeNotifierProvider(create: (_) => RequestInfoProvider()),
      ],
      child: MaterialApp(
        title: 'Lost N Found',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF4F5BD5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF4F5BD5),
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F5BD5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        initialRoute: '/signup', // Start with signup for authentication flow
        routes: {
          '/home': (context) => const HomeScreen(),
          '/create_post': (context) => const CreatePostScreen(),
          '/claim_item': (context) => const ClaimItemScreen(),
          '/claim_info': (context) => const ClaimInfoScreen(),
          '/request_more_info': (context) => const RequestMoreInfoScreen(),
          '/signup': (context) => SignUpScreen(),
          '/login': (context) => LoginScreen(),
          '/passwordChanged': (context) => const PasswordChangedScreen(),
        },
      ),
    );
  }
}
