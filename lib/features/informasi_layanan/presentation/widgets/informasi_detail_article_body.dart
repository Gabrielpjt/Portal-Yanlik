import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class InformasiDetailArticleBody extends StatelessWidget {
  final Map<String, dynamic> article;

  const InformasiDetailArticleBody({
    super.key,
    required this.article,
  });

  List<Map<String, dynamic>> get _contentBlocks {
    final rawBlocks = article['contentBlocks'];

    if (rawBlocks is! List) {
      return [
        {
          'title': null,
          'body': article['description'] ?? '',
        },
      ];
    }

    return rawBlocks
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  String get _editor => article['editor'] ?? 'Audira Sadikin';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._contentBlocks.map((block) {
          return _ArticleBlock(block: block);
        }),

        const SizedBox(height: 8),

        Text(
          'Editor: $_editor',
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ArticleBlock extends StatelessWidget {
  final Map<String, dynamic> block;

  const _ArticleBlock({
    required this.block,
  });

  @override
  Widget build(BuildContext context) {
    final title = block['title'];
    final body = block['body'] ?? '';
    final hasTitle = title is String && title.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasTitle) ...[
            Text(
              title,
              style: const TextStyle(
                color: AppColors.contentPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 3),
          ],
          Text(
            body,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 14,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}