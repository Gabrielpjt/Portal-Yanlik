import 'package:flutter/material.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../core/constants/app_assets.dart';

/// Logo Garuda Pancasila dalam lingkaran, digunakan di halaman login.
///
/// Menggunakan asset lokal [AppAssets.logoGaruda].
/// Fallback ke icon [Icons.account_balance] jika asset gagal dimuat.
///
/// Usage:
/// ```dart
/// GarudaEmblem()
/// GarudaEmblem(size: 80)
/// ```
class GarudaEmblem extends StatelessWidget {
  final double size;

  const GarudaEmblem({super.key, this.size = 72});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.strokePrimary, width: 1),
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.logoGaruda,
          fit: BoxFit.cover,
          errorBuilder: (context, error, _) => Icon(
            Icons.account_balance,
            size: size * 0.5,
            color: AppColors.brandPrimary,
          ),
        ),
      ),
    );
  }
}
