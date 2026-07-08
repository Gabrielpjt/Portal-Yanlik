import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// A subtle section divider label for the sidebar.
///
/// Used to separate logical groups of menu items (e.g. "Profil Anda").
/// Renders as a light-weight text label with secondary color.
class SidebarSectionHeader extends StatelessWidget {
  final String title;

  const SidebarSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.contentSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
