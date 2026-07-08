import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

enum CustomButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonType type;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CustomButtonType.primary,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.width = double.infinity,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = backgroundColor ?? _getDefaultBackgroundColor();
    final effectiveTextColor = textColor ?? _getDefaultTextColor();
    final effectiveBorderColor = _getDefaultBorderColor();

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: type == CustomButtonType.outline || type == CustomButtonType.text
            ? Colors.transparent
            : effectiveBgColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              border: type == CustomButtonType.outline
                  ? Border.all(color: effectiveBorderColor, width: 1.5)
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: effectiveTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getDefaultBackgroundColor() {
    switch (type) {
      case CustomButtonType.primary:
        return AppColors.brandPrimary;
      case CustomButtonType.secondary:
        return AppColors.guide100;
      case CustomButtonType.outline:
      case CustomButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getDefaultTextColor() {
    switch (type) {
      case CustomButtonType.primary:
        return Colors.white;
      case CustomButtonType.secondary:
      case CustomButtonType.outline:
      case CustomButtonType.text:
        return AppColors.brandPrimary;
    }
  }

  Color _getDefaultBorderColor() => AppColors.strokePrimary;
}
