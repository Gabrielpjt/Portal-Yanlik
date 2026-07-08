import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class BenefitTextSection extends StatelessWidget {
  final String title;
  final String description;

  const BenefitTextSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return _BenefitSectionWrapper(
      title: title,
      child: Text(
        description,
        style: const TextStyle(
          color: AppColors.contentPrimary,
          fontSize: 14,
          height: 1.45,
        ),
      ),
    );
  }
}

class BenefitBreakdownItem {
  final String title;
  final String subtitle;

  const BenefitBreakdownItem({
    required this.title,
    required this.subtitle,
  });
}

class BenefitBreakdownSection extends StatelessWidget {
  final String title;
  final String description;
  final List<BenefitBreakdownItem> items;

  const BenefitBreakdownSection({
    super.key,
    this.title = 'Rincian Bantuan',
    required this.description,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return _BenefitSectionWrapper(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 14,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: AppColors.strokePrimary,
              ),
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isLast = index == items.length - 1;

                return _BreakdownTile(
                  item: item,
                  showDivider: !isLast,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitTimelineItem {
  final String title;
  final String description;
  final String amount;

  const BenefitTimelineItem({
    required this.title,
    required this.description,
    required this.amount,
  });
}

class BenefitTimelineSection extends StatelessWidget {
  final String title;
  final List<BenefitTimelineItem> items;

  const BenefitTimelineSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return _BenefitSectionWrapper(
      title: title,
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;

          return _TimelineTile(
            item: item,
            isLast: isLast,
          );
        }).toList(),
      ),
    );
  }
}

class _BenefitSectionWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const _BenefitSectionWrapper({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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

        const SizedBox(height: 14),

        child,
      ],
    );
  }
}

class _BreakdownTile extends StatelessWidget {
  final BenefitBreakdownItem item;
  final bool showDivider;

  const _BreakdownTile({
    required this.item,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        if (showDivider)
          const Divider(
            height: 1,
            thickness: 0.5,
            color: AppColors.strokePrimary,
          ),
      ],
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final BenefitTimelineItem item;
  final bool isLast;

  const _TimelineTile({
    required this.item,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 18,
            child: Column(
              children: [
                Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                    color: Color(0xFF16863D),
                    shape: BoxShape.circle,
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: const Color(0xFF16863D),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: AppColors.contentPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    item.description,
                    style: const TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    item.amount,
                    style: const TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}