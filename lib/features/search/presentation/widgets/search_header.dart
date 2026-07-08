import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SearchHeader extends StatelessWidget {
  final String breadcrumbParent;
  final String currentPage;

  const SearchHeader({
    super.key,
    this.breadcrumbParent = 'Beranda',
    this.currentPage = 'Pencarian',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.strokePrimary, width: 1),
        ),
      ),
      child: Row(
        children: [
          Text(
            breadcrumbParent,
            style: const TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right,
            size: 16,
            color: AppColors.contentSecondary,
          ),
          const SizedBox(width: 8),
          Text(
            currentPage,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
