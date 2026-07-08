import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class HelpfulReviewSection extends StatefulWidget {
  final String title;
  final String description;
  final String hintText;
  final String buttonLabel;
  final double initialRating;
  final void Function(double rating, String review)? onSubmit;

  const HelpfulReviewSection({
    super.key,
    this.title = 'Apakah informasi ini membantu?',
    this.description =
    'Berikan masukan Anda agar kami bisa meningkatkan layanan ini.',
    this.hintText = 'Tulis ulasan disini',
    this.buttonLabel = 'Kirim ulasan',
    this.initialRating = 3.5,
    this.onSubmit,
  });

  @override
  State<HelpfulReviewSection> createState() {
    return _HelpfulReviewSectionState();
  }
}

class _HelpfulReviewSectionState extends State<HelpfulReviewSection> {
  late double _rating;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    widget.onSubmit?.call(
      _rating,
      _reviewController.text,
    );
  }

  IconData _getStarIcon(int index) {
    final starValue = index + 1;

    if (_rating >= starValue) {
      return Icons.star_rounded;
    }

    if (_rating >= starValue - 0.5) {
      return Icons.star_half_rounded;
    }

    return Icons.star_rounded;
  }

  Color _getStarColor(int index) {
    final starValue = index + 1;

    if (_rating >= starValue - 0.5) {
      return const Color(0xFFFFC107);
    }

    return const Color(0xFFE5E7EB);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            height: 1.25,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          widget.description,
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 12,
            height: 1.35,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            const Text(
              'Beri Rating',
              style: TextStyle(
                color: AppColors.contentPrimary,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 10),

            Row(
              children: List.generate(
                5,
                    (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Icon(
                        _getStarIcon(index),
                        size: 23,
                        color: _getStarColor(index),
                      ),
                    ),
                  );
                },
              ),
            ),
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
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _reviewController,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.contentPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 11,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const Padding(
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
            onPressed: _submitReview,
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
            child: Text(
              widget.buttonLabel,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
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