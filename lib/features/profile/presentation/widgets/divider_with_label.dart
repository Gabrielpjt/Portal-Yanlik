import 'package:flutter/material.dart';
import '../../../../../app/theme/app_colors.dart';

/// Divider horizontal dengan label teks di tengah.
///
/// Renders: ─────── [label] ───────
///
/// Usage:
/// ```dart
/// DividerWithLabel(label: 'Dapatkan aplikasi IKD melalui')
/// DividerWithLabel(label: 'atau', compact: true)
/// ```
class DividerWithLabel extends StatelessWidget {
  final String label;

  /// Jika true, font lebih kecil dan padding horizontal lebih rapat.
  final bool compact;

  final Color? dividerColor;
  final TextStyle? labelStyle;

  const DividerWithLabel({
    super.key,
    required this.label,
    this.compact = false,
    this.dividerColor,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor ?? AppColors.strokePrimary,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12),
          child: Text(
            label,
            style: labelStyle ??
                TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: compact ? 11 : 12,
                ),
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor ?? AppColors.strokePrimary,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
