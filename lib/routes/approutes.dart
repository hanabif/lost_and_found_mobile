import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/navigation/main_navigation.dart';
import 'package:lost_and_found_mobile/screens/home/splash_screen.dart';
import 'package:lost_and_found_mobile/screens/found_items_list/found_item_list.dart';
import 'package:lost_and_found_mobile/screens/post_found_item/post_found_item_screen.dart';
import 'package:lost_and_found_mobile/screens/my_claims/my_claims_screen.dart';
import 'package:lost_and_found_mobile/screens/profile/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String lostItems = '/lost-items';
  static const String createPost = '/create-post';
  static const String myClaims = '/my-claims';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      case lostItems:
        return MaterialPageRoute(builder: (_) => const FoundItemsPage());
      case createPost:
        return MaterialPageRoute(builder: (_) => const CreatePostScreen());
      case myClaims:
        return MaterialPageRoute(builder: (_) =>  MyClaimsScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
