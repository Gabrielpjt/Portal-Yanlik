import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../navigation/main_navigation_controller.dart';

/// Widget breadcrumb navigasi reusable.
///
/// Contoh tampilan
/// Beranda > ... > Halaman Aktif
class BreadcrumbWidget extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final EdgeInsetsGeometry padding;

  const BreadcrumbWidget({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  });

  VoidCallback? _getItemAction({
    required BreadcrumbItem item,
    required bool isLast,
  }) {
    if (isLast) {
      return null;
    }

    final normalizedLabel = item.label.trim().toLowerCase();
    final navigationController = MainNavigationController.instance;

    if (navigationController.isAttached) {
      if (normalizedLabel == 'beranda') {
        return navigationController.goHome;
      }

      if (normalizedLabel == '...' ||
          normalizedLabel == 'layanan' ||
          normalizedLabel == 'menu layanan') {
        return navigationController.goServices;
      }
    }

    return item.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 6,
        runSpacing: 6,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    final widgets = <Widget>[];

    for (int index = 0; index < items.length; index++) {
      final item = items[index];
      final isLast = index == items.length - 1;
      final onTap = _getItemAction(
        item: item,
        isLast: isLast,
      );

      widgets.add(
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 3,
            ),
            child: Text(
              item.label,
              style: TextStyle(
                color: isLast
                    ? AppColors.contentSecondary
                    : AppColors.brandPrimary,
                fontSize: 13,
                fontWeight: isLast
                    ? FontWeight.w500
                    : FontWeight.w600,
              ),
            ),
          ),
        ),
      );

      if (!isLast) {
        widgets.add(
          const Icon(
            Icons.chevron_right_rounded,
            size: 16,
            color: AppColors.contentSecondary,
          ),
        );
      }
    }

    return widgets;
  }
}

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;

  const BreadcrumbItem({
    required this.label,
    this.onTap,
  });
}
