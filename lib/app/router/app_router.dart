import 'package:flutter/material.dart';
import '../../features/main_navigation_page.dart';
import '../../features/api_test/presentation/pages/api_test_page.dart';

class AppRouter {
  static const String main = '/';
  static const String search = '/search';
  static const String services = '/services';
  static const String profile = '/profile';
  static const String apiTest = '/api-test';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint('AppRouter.onGenerateRoute called with: ${settings.name}');
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationPage(),
        );
      case apiTest:
        return MaterialPageRoute(
          builder: (_) => const ApiTestPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
