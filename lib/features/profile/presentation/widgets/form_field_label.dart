import 'package:flutter/material.dart';
import '../../../../../app/theme/app_colors.dart';

/// Label field form dengan tanda asterisk merah opsional untuk field wajib.
///
/// Usage:
/// ```dart
/// FormFieldLabel(label: 'Nomor Induk Kependudukan', isRequired: true)
/// FormFieldLabel(label: 'Catatan')
/// ```
class FormFieldLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextStyle? style;

  const FormFieldLabel({
    super.key,
    required this.label,
    this.isRequired = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRequired) {
      return Text(
        label,
        style: style ??
            const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
      );
    }

    return RichText(
      text: TextSpan(
        text: label,
        style: style ??
            const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
