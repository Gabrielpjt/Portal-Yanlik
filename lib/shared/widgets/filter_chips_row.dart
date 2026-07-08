import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Model data untuk satu item chip filter.
class FilterChipItem {
  final String key;
  final String label;
  final int count;

  const FilterChipItem({
    required this.key,
    required this.label,
    required this.count,
  });
}

/// Widget reusable berupa scrollable row chip filter dengan badge count.
///
/// Digunakan di [SearchPage] dan [InformasiLayananPage].
///
/// Contoh:
/// ```dart
/// FilterChipsRow(
///   chips: [
///     FilterChipItem(key: 'all', label: 'Semua', count: 20),
///     FilterChipItem(key: 'kependudukan', label: 'Kependudukan', count: 5),
///   ],
///   selectedKey: 'all',
///   onSelected: (key) => setState(() => _selected = key),
/// )
/// ```
class FilterChipsRow extends StatelessWidget {
  final List<FilterChipItem> chips;
  final String selectedKey;
  final Function(String) onSelected;

  const FilterChipsRow({
    super.key,
    required this.chips,
    required this.selectedKey,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.asMap().entries.map((entry) {
          final index = entry.key;
          final chip = entry.value;
          return Padding(
            padding: EdgeInsets.only(right: index < chips.length - 1 ? 8 : 0),
            child: _buildChip(chip),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChip(FilterChipItem chip) {
    final isSelected = chip.key == selectedKey;
    return GestureDetector(
      onTap: () => onSelected(chip.key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandPrimary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? AppColors.brandPrimary : AppColors.strokePrimary,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              chip.label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.contentPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                chip.count.toString(),
                style: TextStyle(
                  color: isSelected
                      ? AppColors.brandPrimary
                      : AppColors.contentSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
