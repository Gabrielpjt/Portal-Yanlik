import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

/// Reusable text field with consistent app styling.
///
/// Automatically applies a [Theme] override to prevent Material 3
/// from injecting gray surface tint on the fill color.
///
/// Usage:
/// ```dart
/// // Plain field
/// CustomTextField(hintText: 'Search...')
///
/// // With label
/// CustomTextField(
///   label: 'Email',
///   hintText: 'you@example.com',
///   keyboardType: TextInputType.emailAddress,
/// )
///
/// // Password field
/// CustomTextField(
///   label: 'Password',
///   obscureText: true,
///   suffixIcon: IconButton(...),
/// )
/// ```
class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final EdgeInsetsGeometry contentPadding;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.borderRadius = 8.0,
    this.fillColor,
    this.borderColor,
    this.onChanged,
    this.maxLength,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveFill = fillColor ?? Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 6),
        ],
        // Theme override prevents Material 3 gray surface tint
        Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: effectiveFill,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            maxLength: maxLength,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 13.5,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: effectiveFill,
              counterText: '',
              contentPadding: contentPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.strokePrimary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.strokePrimary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: AppColors.brandPrimary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
