import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/helpful_review_section.dart';

class ServiceReviewRelatedSection extends StatelessWidget {
  final bool showRelatedService;

  const ServiceReviewRelatedSection({
    super.key,
    this.showRelatedService = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HelpfulReviewSection(),

        if (showRelatedService) ...[
          const Divider(
            height: 40,
            thickness: 0.5,
          ),
          const _RelatedServiceSection(),
        ],
      ],
    );
  }
}

class _RelatedServiceSection extends StatelessWidget {
  const _RelatedServiceSection();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Layanan Terkait',
            style: TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Layanan',
            style: TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 10,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Pengurusan Akta Kelahiran',
            style: TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Ajukan pembuatan akta kelahiran baru untuk keperluan pencatatan sipil anak Anda.',
            style: TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 11,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}