import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ServiceDetailOverviewCard extends StatelessWidget {
  final String title;
  final VoidCallback? onShareTap;
  final VoidCallback? onAccessTap;

  const ServiceDetailOverviewCard({
    super.key,
    required this.title,
    this.onShareTap,
    this.onAccessTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    size: 14,
                    color: AppColors.contentSecondary,
                  ),
                  const SizedBox(width: 5),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: AppColors.contentSecondary,
                        fontSize: 11,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terakhir diperbaharui ',
                        ),
                        TextSpan(
                          text: '25 Feb 2026',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.contentPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF8EE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Aktif',
                  style: TextStyle(
                    color: Color(0xFF2D9A4D),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 42,
            child: OutlinedButton(
              onPressed: onShareTap ?? () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.contentPrimary,
                side: const BorderSide(
                  color: AppColors.strokePrimary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bagikan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 7),
                  Icon(
                    Icons.share_outlined,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 42,
            child: ElevatedButton(
              onPressed: onAccessTap ?? () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.brandPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Akses layanan',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}