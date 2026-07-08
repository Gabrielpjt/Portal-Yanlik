import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Widget paginasi reusable yang digunakan di seluruh fitur.
///
/// Menampilkan tombol: «  <  1  2  3  …  >  »
/// Gunakan di [SearchPage], [InformasiLayananPage], [BenefitPage], dll.
class AppPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  /// Hitung daftar halaman yang ditampilkan (maks 5 nomor).
  List<int> _visiblePages() {
    if (totalPages <= 5) {
      return List.generate(totalPages, (i) => i + 1);
    }
    if (currentPage <= 3) {
      return [1, 2, 3, 4, 5];
    }
    if (currentPage >= totalPages - 2) {
      return List.generate(5, (i) => totalPages - 4 + i);
    }
    return [
      currentPage - 2,
      currentPage - 1,
      currentPage,
      currentPage + 1,
      currentPage + 2,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _visiblePages();
    final isFirst = currentPage == 1;
    final isLast = currentPage == totalPages;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // « First
            _NavBtn(
              icon: Icons.keyboard_double_arrow_left,
              enabled: !isFirst,
              onTap: () => onPageChanged(1),
            ),
            const SizedBox(width: 4),
            // < Prev
            _NavBtn(
              icon: Icons.chevron_left,
              enabled: !isFirst,
              onTap: () => onPageChanged(currentPage - 1),
            ),
            const SizedBox(width: 6),

            // Page numbers
            ...pages.map((p) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _PageNumBtn(
                  number: p,
                  isActive: p == currentPage,
                  onTap: () => onPageChanged(p),
                ),
              );
            }),

            const SizedBox(width: 6),
            // > Next
            _NavBtn(
              icon: Icons.chevron_right,
              enabled: !isLast,
              onTap: () => onPageChanged(currentPage + 1),
            ),
            const SizedBox(width: 4),
            // » Last
            _NavBtn(
              icon: Icons.keyboard_double_arrow_right,
              enabled: !isLast,
              onTap: () => onPageChanged(totalPages),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Navigation arrow button ───────────────────────────────────────────────────

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.strokePrimary),
          ),
          child: Icon(
            icon,
            size: 18,
            color: enabled
                ? AppColors.contentPrimary
                : AppColors.contentSecondary.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}

// ── Page number button ────────────────────────────────────────────────────────

class _PageNumBtn extends StatelessWidget {
  final int number;
  final bool isActive;
  final VoidCallback onTap;

  const _PageNumBtn({
    required this.number,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? AppColors.brandPrimary : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: isActive ? null : onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  isActive ? AppColors.brandPrimary : AppColors.strokePrimary,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.contentPrimary,
                fontSize: 14,
                fontWeight:
                    isActive ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
