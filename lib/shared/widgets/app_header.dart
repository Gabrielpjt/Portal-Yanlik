import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../core/constants/app_assets.dart';
import '../navigation/main_navigation_controller.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final bool isLoggedIn;
  final bool showLoginButton;

  const AppHeader({
    super.key,
    this.onMenuTap,
    this.onLoginTap,
    this.isLoggedIn = false,
    this.showLoginButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Menu Icon
            if (isLoggedIn)
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.menu, size: 20),
                    color: AppColors.brandPrimary,
                    onPressed: () {
                      final controller =
                          MainNavigationController.instance;

                      if (controller.isAttached) {
                        controller.openMenu();
                        return;
                      }

                      onMenuTap?.call();
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              )
            else
              IconButton(
                icon: const Icon(Icons.menu, size: 28),
                color: AppColors.brandPrimary,
                onPressed: () {
                  final controller =
                      MainNavigationController.instance;

                  if (controller.isAttached) {
                    controller.openMenu();
                    return;
                  }

                  onMenuTap?.call();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

            const SizedBox(width: 12),

            // Logo INAKU
            Expanded(
              child: Image.asset(
                AppAssets.logoInaku,
                height: 36,
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
                errorBuilder: (context, error, stackTrace) {
                  return RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'INA',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.brandPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        TextSpan(
                          text: 'ku',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            color: AppColors.brandPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Location Dropdown
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(18),
              child: const SizedBox(
                height: 36,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: AppColors.brandPrimary,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.brandPrimary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (isLoggedIn) ...[
              const SizedBox(width: 14),

              Container(
                width: 1,
                height: 20,
                color: AppColors.strokePrimary,
              ),

              const SizedBox(width: 10),

              // Notification Bell
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.brandPrimary,
                      size: 19,
                    ),
                  ),

                  Positioned(
                    top: -3,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                      child: const Text(
                        '9+',
                        style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            if (showLoginButton && !isLoggedIn) ...[
              const SizedBox(width: 12),

              // Masuk Button
              ElevatedButton(
                onPressed: () {
                  final controller =
                      MainNavigationController.instance;

                  if (controller.isAttached) {
                    controller.goLogin();
                    return;
                  }

                  onLoginTap?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.chevron_right, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
