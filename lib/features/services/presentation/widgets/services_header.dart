import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';

class ServicesHeader extends StatelessWidget {
  final int totalLayanan;
  final int totalProgram;
  final ValueChanged<String>? onSearchChanged;

  const ServicesHeader({
    super.key,
    required this.totalLayanan,
    this.totalProgram = 0,
    this.onSearchChanged,
  });

  String get _subtitle {
    if (totalProgram > 0) {
      return '$totalLayanan Layanan    $totalProgram Program';
    }

    return '$totalLayanan Layanan';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BreadcrumbWidget(
            padding: EdgeInsets.zero,
            items: [
              BreadcrumbItem(label: 'Beranda'),
              BreadcrumbItem(label: 'Layanan Publik'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Layanan Publik',
            style: TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _subtitle,
            style: const TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: onSearchChanged,
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
