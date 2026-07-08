import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ServiceListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const ServiceListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.contentSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(
                Icons.arrow_outward,
                color: AppColors.contentSecondary,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceGridItem extends ServiceListItem {
  const ServiceGridItem({
    super.key,
    required super.title,
    super.subtitle,
    super.onTap,
  });
}