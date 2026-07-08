import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ProfileBenefitSection extends StatelessWidget {
  final List<String> benefits;
  final String totalBenefitsLabel;

  const ProfileBenefitSection({
    super.key,
    required this.benefits,
    required this.totalBenefitsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Benefit yang di miliki',
                      style: TextStyle(
                        color: AppColors.contentPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      totalBenefitsLabel,
                      style: const TextStyle(
                        color: AppColors.contentSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    color: AppColors.guide600,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...benefits.map((b) => _BenefitChip(label: b)),
              const _BenefitChip(label: '+2', isMore: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _BenefitChip extends StatelessWidget {
  final String label;
  final bool isMore;

  const _BenefitChip({required this.label, this.isMore = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isMore ? const Color(0xFFF1F5F9) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isMore ? const Color(0xFF475569) : AppColors.contentPrimary,
          fontSize: 12,
          fontWeight: isMore ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}
