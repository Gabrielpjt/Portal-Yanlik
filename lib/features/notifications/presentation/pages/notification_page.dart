import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../widgets/notification_content.dart';

class NotificationPage extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final bool isLoggedIn;

  const NotificationPage({
    super.key,
    this.onMenuTap,
    this.onLoginTap,
    this.isLoggedIn = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              onMenuTap: onMenuTap,
              onLoginTap: onLoginTap,
              isLoggedIn: isLoggedIn,
            ),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: const NotificationContent(),
              ),
            ),

            const SizedBox(height: 24),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}