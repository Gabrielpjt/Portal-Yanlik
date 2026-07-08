import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../app/theme/app_colors.dart';

class StoreButton extends StatelessWidget {
  final StoreType type;
  final VoidCallback? onTap;
  final double height;

  const StoreButton({
    super.key,
    required this.type,
    this.onTap,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.strokePrimary,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(width: 10),
            Text(
              type.label,
              style: const TextStyle(
                color: AppColors.contentPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    switch (type) {
      case StoreType.googlePlay:
        return const FaIcon(
          FontAwesomeIcons.google,
          size: 18,
          color: AppColors.contentPrimary,
        );

      case StoreType.appleStore:
        return const FaIcon(
          FontAwesomeIcons.apple,
          size: 19,
          color: AppColors.contentPrimary,
        );
    }
  }
}

enum StoreType {
  googlePlay('Google Play'),
  appleStore('Apple Store');

  final String label;

  const StoreType(this.label);
}