import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../informasi_layanan/presentation/bloc/informasi_layanan_bloc.dart';
import '../../../informasi_layanan/presentation/bloc/informasi_layanan_state.dart';

class LatestInfoSection extends StatelessWidget {
  final VoidCallback? onLihatSemuaTap;
  final VoidCallback? onCardTap;

  const LatestInfoSection({
    super.key,
    this.onLihatSemuaTap,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformasiLayananBloc, InformasiLayananState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Info Layanan Terbaru',
              style: TextStyle(
                color: AppColors.brandPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 32 / 24,
              ),
            ),
            const SizedBox(height: 16),
            if (state.status == InformasiLayananStatus.loading)
              const _LoadingPlaceholder(),
            if (state.status == InformasiLayananStatus.error)
              _ErrorCard(message: state.errorMessage),
            if (state.status == InformasiLayananStatus.loaded) ...[
              if (state.items.isEmpty)
                const _EmptyCard()
              else
                ...state.items.map(
                      (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: onCardTap,
                      borderRadius: BorderRadius.circular(12),
                      child: _buildInfoCard(
                        imageUrl: item.thumbnailUrl ?? item.imageUrl,
                        title: item.judul,
                        description: item.deskripsi,
                        category: _categoryLabel(
                          item.kategoriInformasiLayananId,
                        ),
                        date: _formatDate(item.dibuatPada),
                      ),
                    ),
                  ),
                ),
            ],
            if (state.status == InformasiLayananStatus.initial)
              const _LoadingPlaceholder(),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: onLihatSemuaTap,
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// TODO: Ganti ini ke nama kategori dari API kalau preload kategori informasi
  /// layanan sudah tersedia di state.
  static String _categoryLabel(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'Layanan Umum';
      case 2:
        return 'Bantuan Sosial';
      case 3:
        return 'Kesehatan';
      default:
        return 'Informasi';
    }
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return '-';
    try {
      return DateFormat('dd MMM yyyy', 'id_ID').format(date);
    } catch (_) {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  Widget _buildInfoCard({
    String? imageUrl,
    required String title,
    required String description,
    required String category,
    required String date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _imagePlaceholder();
                  },
                )
                    : _imagePlaceholder(),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_outward,
                    size: 20,
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.brandPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.guide100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: AppColors.guide600,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: AppColors.contentSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          date,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      height: 160,
      color: AppColors.backgroundSecondary,
      child: const Center(
        child: Icon(
          Icons.image,
          size: 48,
          color: AppColors.contentSecondary,
        ),
      ),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18,
                  width: 200,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 13,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 13,
                  width: 160,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(4),
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

class _ErrorCard extends StatelessWidget {
  final String message;

  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message.isNotEmpty
                  ? message
                  : 'Gagal memuat informasi layanan.',
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'Belum ada informasi layanan.',
          style: TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
