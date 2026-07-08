import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// A reusable footer for the sidebar/drawer containing:
/// - "Syarat dan Ketentuan" and "Kebijakan Privasi" tappable links
/// - Copyright text
///
/// Both link callbacks are optional so the consumer can wire
/// navigation or URL launching as needed.
class SidebarFooter extends StatelessWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const SidebarFooter({
    super.key,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Links row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTermsTap,
              child: const Text(
                'Syarat dan Ketentuan',
                style: TextStyle(
                  color: AppColors.contentPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '|',
                style: TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 12,
                ),
              ),
            ),
            GestureDetector(
              onTap: onPrivacyTap,
              child: const Text(
                'Kebijakan Privasi',
                style: TextStyle(
                  color: AppColors.contentPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Copyright
        const Text(
          'Copyright © 2026. INAKU. All right reserved.',
          style: TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
