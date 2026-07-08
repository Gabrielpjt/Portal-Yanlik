import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ServiceReviewRelatedSection extends StatelessWidget {
  final bool showRelatedService;

  const ServiceReviewRelatedSection({
    super.key,
    this.showRelatedService = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _ReviewSection(),

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

class _ReviewSection extends StatelessWidget {
  const _ReviewSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Apakah informasi ini membantu?',
          style: TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Berikan masukan Anda agar kami bisa meningkatkan layanan ini.',
          style: TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 14),
        const Row(
          children: [
            Text(
              'Beri Rating',
              style: TextStyle(
                color: AppColors.contentPrimary,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 10),
            _RatingStars(),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 145,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: AppColors.strokePrimary,
            ),
          ),
          child: const Column(
            children: [
              Expanded(
                child: TextField(
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.contentPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Tulis ulasan disini',
                    hintStyle: TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 11,
                    ),
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 4, 12, 10),
                child: _EditorToolbar(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 42,
          child: ElevatedButton(
            onPressed: _emptyCallback,
            style: const ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(
                AppColors.brandPrimary,
              ),
              foregroundColor: WidgetStatePropertyAll(
                Colors.white,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
            child: const Text(
              'Kirim ulasan',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void _emptyCallback() {}
}

class _RatingStars extends StatelessWidget {
  const _RatingStars();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Icon(
              Icons.star_rounded,
              size: 23,
              color: index < 4
                  ? const Color(0xFFFFC107)
                  : const Color(0xFFE5E7EB),
            ),
          );
        },
      ),
    );
  }
}

class _EditorToolbar extends StatelessWidget {
  const _EditorToolbar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _ToolbarText(text: 'B'),
        SizedBox(width: 14),
        _ToolbarText(
          text: 'I',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(width: 14),
        _ToolbarText(
          text: 'U',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(width: 14),
        Icon(
          Icons.format_strikethrough,
          size: 15,
          color: AppColors.contentPrimary,
        ),
        SizedBox(width: 14),
        Icon(
          Icons.format_list_numbered,
          size: 15,
          color: AppColors.contentPrimary,
        ),
        SizedBox(width: 14),
        Icon(
          Icons.format_list_bulleted,
          size: 15,
          color: AppColors.contentPrimary,
        ),
        SizedBox(width: 14),
        Icon(
          Icons.link,
          size: 15,
          color: AppColors.contentPrimary,
        ),
      ],
    );
  }
}

class _ToolbarText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const _ToolbarText({
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.contentPrimary,
        fontSize: 12,
      ).merge(style),
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
            'Ajukan pembuatan akta kelahiran baru untuk '
                'keperluan pencatatan sipil anak Anda.',
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