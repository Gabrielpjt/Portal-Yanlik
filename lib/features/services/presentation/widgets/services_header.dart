import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ServicesHeader extends StatelessWidget {
  const ServicesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              const Text(
                'Beranda',
                style: TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right,
                size: 16,
                color: AppColors.contentSecondary,
              ),
              const SizedBox(width: 6),
              const Text(
                'Layanan Publik',
                style: TextStyle(
                  color: AppColors.brandPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Title
          const Text(
            'Layanan Publik',
            style: TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle
          const Text(
            '20 Layanan    6 Program',
            style: TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari layanan atau program',
              hintStyle: const TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.contentSecondary,
              ),
              filled: true,
              fillColor: AppColors.backgroundSecondary,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.strokePrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.strokePrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.brandPrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
