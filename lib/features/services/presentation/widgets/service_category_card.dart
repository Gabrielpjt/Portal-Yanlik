import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ServiceCategoryCard extends StatelessWidget {
  final String title;
  final String count;
  final String description;
  final List<Map<String, String>> services;
  final List<Map<String, String>> programs;
  final bool isActive;
  final void Function(int serviceId, String serviceTitle)? onItemTap;

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

  bool _isDisplayableItem(Map<String, String> item) {
    final name = item['name']?.trim() ?? '';
    final normalizedName = name.toLowerCase();

    return name.isNotEmpty && normalizedName != 'tanpa nama';
  }

  @override
  Widget build(BuildContext context) {
    final allItems = <Map<String, String>>[
      ...services,
      ...programs,
    ].where(_isDisplayableItem).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.brandPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
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
        Text(
          description,
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 15,
          ),
        ),
        if (allItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          ...List.generate((allItems.length / 2).ceil(), (rowIndex) {
            final leftIndex = rowIndex * 2;
            final rightIndex = leftIndex + 1;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildServiceItem(allItems[leftIndex]),
                  ),
                  const SizedBox(width: 16),
                  if (rightIndex < allItems.length)
                    Expanded(
                      child: _buildServiceItem(allItems[rightIndex]),
                    )
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            );
          }),
        ],
        const SizedBox(height: 20),
        const Divider(
          color: AppColors.strokePrimary,
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }

  Widget _buildServiceItem(Map<String, String> item) {
    final id = int.tryParse(item['id'] ?? '') ?? 0;
    final name = item['name']?.trim() ?? '';
    final type = item['type']?.trim() ?? 'Layanan';

    return InkWell(
      onTap: id == 0 || name.isEmpty ? null : () => onItemTap?.call(id, name),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
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
