import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class BenefitSummaryInfo {
  final String label;
  final String value;
  final String caption;
  final bool showCurrencyPrefix;

  const BenefitSummaryInfo({
    required this.label,
    required this.value,
    required this.caption,
    this.showCurrencyPrefix = true,
  });
}

class BenefitDetailOverviewCard extends StatelessWidget {
  final String title;
  final String statusDate;
  final String statusLabel;
  final List<BenefitSummaryInfo> items;

  const BenefitDetailOverviewCard({
    super.key,
    required this.title,
    required this.statusDate,
    required this.statusLabel,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              const Text(
                'Status per ',
                style: TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                statusDate,
                style: const TextStyle(
                  color: AppColors.contentPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              _StatusBadge(label: statusLabel),
            ],
          ),
          const SizedBox(height: 16),

          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 12,
              ),
              child: _SummaryItemCard(item: item),
            );
          }),
        ],
      ),
    );
  }
}

class _SummaryItemCard extends StatelessWidget {
  final BenefitSummaryInfo item;

  const _SummaryItemCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(6,6,6,6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: const TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.brandPrimary,
                    ),
                    children: [
                      if (item.showCurrencyPrefix)
                        const TextSpan(
                          text: 'Rp. ',
                          style: TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      TextSpan(
                        text: item.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brandPrimary,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  item.caption,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 11,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;

  const _StatusBadge({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF15803D),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}