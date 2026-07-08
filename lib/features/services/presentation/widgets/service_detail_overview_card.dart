import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ServiceDetailOverviewCard extends StatelessWidget {
  final String title;
  final String status;
  final String? updatedAt;
  final VoidCallback? onShareTap;
  final VoidCallback? onAccessTap;

  const ServiceDetailOverviewCard({
    super.key,
    required this.title,
    this.status = '',
    this.updatedAt,
    this.onShareTap,
    this.onAccessTap,
  });

  String get _statusLabel {
    final normalizedStatus = status.trim().toUpperCase();

    if (normalizedStatus == 'PUBLISHED') {
      return 'Aktif';
    }

    if (normalizedStatus == 'DRAFT') {
      return 'Draft';
    }

    if (normalizedStatus == 'ARCHIVED') {
      return 'Arsip';
    }

    if (normalizedStatus.isEmpty) {
      return '-';
    }

    return status;
  }

  Color get _statusTextColor {
    final normalizedStatus = status.trim().toUpperCase();

    if (normalizedStatus == 'PUBLISHED') {
      return const Color(0xFF2D9A4D);
    }

    if (normalizedStatus == 'DRAFT') {
      return const Color(0xFFB7791F);
    }

    if (normalizedStatus == 'ARCHIVED') {
      return const Color(0xFF666666);
    }

    return AppColors.contentSecondary;
  }

  Color get _statusBackgroundColor {
    final normalizedStatus = status.trim().toUpperCase();

    if (normalizedStatus == 'PUBLISHED') {
      return const Color(0xFFEAF8EE);
    }

    if (normalizedStatus == 'DRAFT') {
      return const Color(0xFFFFF4DB);
    }

    if (normalizedStatus == 'ARCHIVED') {
      return const Color(0xFFF1F3F5);
    }

    return const Color(0xFFF1F3F5);
  }

  String get _updatedDateText {
    final rawDate = updatedAt?.trim();

    if (rawDate == null || rawDate.isEmpty) {
      return '-';
    }

    final parsedDate = DateTime.tryParse(rawDate);

    if (parsedDate == null) {
      return rawDate;
    }

    const monthNames = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return '${parsedDate.day} ${monthNames[parsedDate.month]} ${parsedDate.year}';
  }

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
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.contentSecondary,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Terakhir diperbarui ',
                        ),
                        TextSpan(
                          text: _updatedDateText,
                          style: const TextStyle(
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
                  color: _statusBackgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _statusLabel,
                  style: TextStyle(
                    color: _statusTextColor,
                    fontSize: 11,
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