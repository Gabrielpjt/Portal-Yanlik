import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ServiceCategoryCard extends StatelessWidget {
  final String title;
  final String count;
  final String description;
  final List<Map<String, String>> services;
  final List<Map<String, String>> programs;
  final bool isActive;
  final ValueChanged<String>? onItemTap;

  const ServiceCategoryCard({
    super.key,
    required this.title,
    required this.count,
    required this.description,
    this.services = const [],
    this.programs = const [],
    this.isActive = false,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final allItems = <Map<String, String>>[
      ...services,
      ...programs,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: const TextStyle(
            color: AppColors.brandPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // Count badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count,
            style: const TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Description
        Text(
          description,
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 15,
          ),
        ),
        if (allItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          // 2-column layout using manual rows
          ...List.generate((allItems.length / 2).ceil(), (rowIndex) {
            final leftIndex = rowIndex * 2;
            final rightIndex = leftIndex + 1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildServiceItem(
                      allItems[leftIndex]['name']!,
                      allItems[leftIndex]['type']!,
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (rightIndex < allItems.length)
                    Expanded(
                      child: _buildServiceItem(
                        allItems[rightIndex]['name']!,
                        allItems[rightIndex]['type']!,
                      ),
                    )
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            );
          }),
        ],
        const SizedBox(height: 20),
        // Thin divider line between categories
        const Divider(
          color: AppColors.strokePrimary,
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }

  Widget _buildServiceItem(String name, String type) {
    return InkWell(
      onTap: () => onItemTap?.call(name),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: const TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(
                color: AppColors.brandPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
