import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../kategori_layanan/domain/entities/kategori_layanan_entity.dart';
import 'service_category_card.dart';

class ServiceCategoryList extends StatelessWidget {
  final List<KategoriLayananEntity> categories;
  final void Function(int serviceId, String serviceTitle)? onServiceTap;
  final Map<String, GlobalKey>? categoryKeys;
  final String selectedCategoryKey;
  final String searchKeyword;
  final bool sortAscending;
  final ValueChanged<String>? onCategorySelected;

  const ServiceCategoryList({
    super.key,
    required this.categories,
    this.onServiceTap,
    this.categoryKeys,
    this.selectedCategoryKey = 'all',
    this.searchKeyword = '',
    this.sortAscending = true,
    this.onCategorySelected,
  });

  String get _normalizedSearch => searchKeyword.trim().toLowerCase();

  int get _totalLayanan {
    return categories.fold<int>(
      0,
          (total, category) => total + _serviceItemsFor(category).length,
    );
  }

  List<KategoriLayananEntity> get _sortedCategories {
    final items = [...categories];
    items.sort((a, b) {
      final comparison = a.nama.toLowerCase().compareTo(b.nama.toLowerCase());
      return sortAscending ? comparison : -comparison;
    });
    return items;
  }

  List<KategoriLayananEntity> get _visibleCategories {
    return _sortedCategories.where((category) {
      if (selectedCategoryKey != 'all' && category.nama != selectedCategoryKey) {
        return false;
      }

      if (_normalizedSearch.isEmpty) {
        return true;
      }

      final categoryMatches = category.nama.toLowerCase().contains(
        _normalizedSearch,
      );
      final serviceMatches = _serviceItemsFor(category).any(
            (item) => (item['name'] ?? '').toLowerCase().contains(_normalizedSearch),
      );

      return categoryMatches || serviceMatches;
    }).toList();
  }

  List<Map<String, String>> _serviceItemsFor(KategoriLayananEntity category) {
    final query = _normalizedSearch;
    final categoryMatches = category.nama.toLowerCase().contains(query);
    final items = <Map<String, String>>[];

    for (final layanan in category.layanan) {
      final rawName = layanan.nama.trim();
      final normalizedName = rawName.toLowerCase();

      if (rawName.isEmpty || normalizedName == 'tanpa nama') {
        continue;
      }

      if (query.isNotEmpty && !categoryMatches && !normalizedName.contains(query)) {
        continue;
      }

      items.add({
        'id': layanan.id.toString(),
        'name': rawName,
        'type': 'Layanan',
      });
    }

    items.sort((a, b) {
      final comparison = (a['name'] ?? '').toLowerCase().compareTo(
        (b['name'] ?? '').toLowerCase(),
      );
      return sortAscending ? comparison : -comparison;
    });

    return items;
  }

  List<FilterChipItem> get _chips {
    return [
      FilterChipItem(
        key: 'all',
        label: 'Semua',
        count: _totalLayanan,
      ),
      ..._sortedCategories.map(
            (category) => FilterChipItem(
          key: category.nama,
          label: category.nama,
          count: _serviceItemsFor(category).length,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final visibleCategories = _visibleCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterChipsRow(
          chips: _chips,
          selectedKey: selectedCategoryKey,
          onSelected: onCategorySelected ?? (_) {},
        ),
        const SizedBox(height: 16),
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
        if (visibleCategories.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 28),
            child: Center(
              child: Text(
                'Layanan tidak ditemukan.',
                style: TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 14,
                ),
              ),
            ),
          )
        else
          ...visibleCategories.map(
                (category) {
              final services = _serviceItemsFor(category);

              return Container(
                key: categoryKeys?[category.nama],
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ServiceCategoryCard(
                    title: category.nama,
                    count: '${services.length} Layanan',
                    description: 'Layanan dan Program',
                    services: services,
                    programs: const [],
                    isActive: selectedCategoryKey == category.nama,
                    onItemTap: (serviceId, serviceTitle) {
                      onServiceTap?.call(serviceId, serviceTitle);
                    },
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
