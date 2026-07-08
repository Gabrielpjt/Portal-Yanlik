import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Widget reusable untuk baris Filter + Sort dropdown.
///
/// Digunakan di [ServicesPage], [SearchPage], dan [InformasiLayananPage].
///
/// Contoh:
/// ```dart
/// FilterSortRow(
///   sortLabel: 'Terbaru',
///   onFilterTap: () {},
///   onSortTap: () {},
/// )
/// ```
class FilterSortRow extends StatelessWidget {
  final String sortLabel;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSortTap;

  const FilterSortRow({
    super.key,
    this.sortLabel = 'Terbaru',
    this.onFilterTap,
    this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Filter Button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onFilterTap ?? () {},
            icon: const Icon(Icons.filter_list, size: 18),
            label: const Text('Filter'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.brandPrimary,
              side: const BorderSide(color: AppColors.strokePrimary),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Sort Dropdown Button
        Expanded(
          child: OutlinedButton(
            onPressed: onSortTap ?? () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.brandPrimary,
              side: const BorderSide(color: AppColors.strokePrimary),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(sortLabel),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
