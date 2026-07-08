import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class InformasiDetailHeader extends StatelessWidget {
  final Map<String, dynamic> article;

  const InformasiDetailHeader({
    super.key,
    required this.article,
  });

  String get _title => article['title'] ?? '-';
  String get _publishedDate => article['publishedDate'] ?? '-';
  String get _author => article['author'] ?? 'Ahmad Haikal';
  String get _imageUrl => article['imageUrl'] ?? '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _title,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 23,
              fontWeight: FontWeight.w800,
              height: 1.18,
            ),
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _MetaInfo(
                  label: 'Diterbitkan Pada',
                  value: 'Rabu, $_publishedDate',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _MetaInfo(
                  label: 'Penulis',
                  value: _author,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Expanded(
                child: _ActionButton(
                  label: 'Sukai',
                  icon: Icons.favorite_border,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _ActionButton(
                  label: 'Bagikan',
                  icon: Icons.share_outlined,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                _imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.backgroundSecondary,
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColors.contentSecondary,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaInfo extends StatelessWidget {
  final String label;
  final String value;

  const _MetaInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ActionButton({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.strokePrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.contentPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              size: 15,
              color: AppColors.contentPrimary,
            ),
          ],
        ),
      ),
    );
  }
}