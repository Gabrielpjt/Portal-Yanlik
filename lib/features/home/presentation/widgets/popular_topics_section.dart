import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class PopularTopicsSection extends StatelessWidget {
  const PopularTopicsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Topik Populer',
          style: TextStyle(
            color: AppColors.brandPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 32 / 24,
          ),
        ),
        const SizedBox(height: 16),

        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _buildTopicChip('Mudik Lebaran 2026'),
            _buildTopicChip('Coretax 2026'),
          ],
        ),
      ],
    );
  }

  Widget _buildTopicChip(String text) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.strokePrimary.withValues(alpha: 0.9),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_rounded,
            size: 17,
            color: AppColors.contentSecondary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}