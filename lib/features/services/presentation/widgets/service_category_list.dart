import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../kategori_layanan/domain/entities/kategori_layanan_entity.dart';
import 'service_category_card.dart';

class ServiceCategoryList extends StatelessWidget {
  final List<KategoriLayananEntity> categories;
  final ValueChanged<String>? onServiceTap;

  const ServiceCategoryList({
    super.key,
    required this.categories,
    this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scrollable Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildActiveChip('Semua', '${categories.length}'),
              ...categories.take(4).map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _buildInactiveChip(cat.nama, '${cat.jumlahLayanan}'),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Info Banner
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.guide100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.guide600.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.guide600,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Untuk melihat layanan dari wilayah lainnya, Anda dapat mengubah lokasi wilayah pada bagian header atau melalui filter.',
                  style: TextStyle(
                    color: AppColors.guide600,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Category Cards
        ...categories.map(
          (category) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ServiceCategoryCard(
              title: category.nama,
              count: '${category.jumlahLayanan} Layanan',
              description: 'Layanan dan Program',
              services: category.layanan
                  .map<Map<String, String>>((e) => {
                        'name': e.nama,
                        'type': 'Layanan',
                      })
                  .toList(),
              programs: const [],
              isActive: false,
              onItemTap: (serviceTitle) {
                onServiceTap?.call(serviceTitle);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveChip(String label, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.brandPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Text(
              count,
              style: const TextStyle(
                color: AppColors.brandPrimary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInactiveChip(String label, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            count,
            style: const TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
