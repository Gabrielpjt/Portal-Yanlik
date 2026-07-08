import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/app_pagination.dart';

class InformasiReviewsSection extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const InformasiReviewsSection({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });

  static const _reviews = [
    {
      'name': 'Sari Melati',
      'date': 'Rabu, 13 Feb 2026',
      'rating': 3.5,
    },
    {
      'name': 'Dewi Lestari',
      'date': 'Rabu, 13 Feb 2026',
      'rating': 3.5,
    },
    {
      'name': 'Intan Permata',
      'date': 'Rabu, 13 Feb 2026',
      'rating': 3.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '15 Ulasan',
          style: TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 42,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari review',
                    hintStyle: const TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 12,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: AppColors.contentSecondary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: AppColors.strokePrimary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: AppColors.strokePrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 42,
              height: 42,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: AppColors.strokePrimary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Icon(
                  Icons.tune,
                  size: 19,
                  color: AppColors.contentPrimary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        ..._reviews.map((review) {
          return _ReviewItem(review: review);
        }),

        const SizedBox(height: 0),

        Center(
          child: AppPagination(
            currentPage: currentPage,
            totalPages: 5,
            onPageChanged: onPageChanged,
          ),
        ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final Map<String, dynamic> review;

  const _ReviewItem({
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final rating = (review['rating'] as num?)?.toDouble() ?? 0;
    final name = review['name']?.toString() ?? '-';
    final date = review['date']?.toString() ?? '-';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 18),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.strokePrimary),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&q=80',
            ),
          ),

          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  final starValue = index + 1;
                  final isFull = rating >= starValue;
                  final isHalf = rating >= starValue - 0.5;

                  return Icon(
                    isFull
                        ? Icons.star_rounded
                        : isHalf
                        ? Icons.star_half_rounded
                        : Icons.star_rounded,
                    size: 20,
                    color: isHalf
                        ? const Color(0xFFFFC107)
                        : const Color(0xFFE5E7EB),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            'Banyak perusahaan yang mulai berinvestasi dalam teknologi canggih, yang akan meningkatkan efisiensi dan kualitas produk. Ini adalah langkah positif yang akan mendorong pertumbuhan ekonomi dan menciptakan lebih banyak lapangan kerja.',
            style: TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            date,
            style: const TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class InformasiRelatedSection extends StatelessWidget {
  final List<Map<String, dynamic>> articles;
  final ValueChanged<Map<String, dynamic>> onArticleTap;

  const InformasiRelatedSection({
    super.key,
    required this.articles,
    required this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Terkait',
          style: TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        ...articles.take(3).map((article) {
          return _RelatedInfoItem(
            article: article,
            onTap: () => onArticleTap(article),
          );
        }),
      ],
    );
  }
}

class _RelatedInfoItem extends StatelessWidget {
  final Map<String, dynamic> article;
  final VoidCallback onTap;

  const _RelatedInfoItem({
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = article['imageUrl'] ?? '';
    final category = article['category'] ?? '-';
    final publishedDate = article['publishedDate'] ?? '-';
    final title = article['title'] ?? '-';
    final likes = article['likes'] ?? '0';
    final comments = article['comments'] ?? '0';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 96,
                    height: 96,
                    color: AppColors.backgroundSecondary,
                    child: const Icon(
                      Icons.image_outlined,
                      color: AppColors.contentSecondary,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          '|',
                          style: TextStyle(
                            color: AppColors.strokePrimary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Diterbitkan $publishedDate',
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.brandPrimary,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 13,
                          color: AppColors.contentSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          likes,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 14,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: AppColors.strokePrimary,
                        ),
                        const Icon(
                          Icons.mode_comment_outlined,
                          size: 13,
                          color: AppColors.contentSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          comments,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}