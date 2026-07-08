import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SearchResultCard extends StatelessWidget {
  final String category;
  final String title;
  final String location;
  final String lastUpdated;
  final String description;
  final VoidCallback onTap;

  const SearchResultCard({
    super.key,
    required this.category,
    required this.title,
    required this.location,
    required this.lastUpdated,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.guide100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: AppColors.guide600,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            title,
            style: const TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          // Location & Date
          Row(
            children: [
              Text(
                location,
                style: const TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '•',
                style: TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Diperbarui pada $lastUpdated',
                style: const TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            description,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 13,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          // Link Button
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Lihat detail',
                  style: TextStyle(
                    color: AppColors.brandPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                    Icons.arrow_outward,
                  color: AppColors.brandPrimary,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
