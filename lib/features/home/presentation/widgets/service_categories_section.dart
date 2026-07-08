import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../kategori_layanan/domain/entities/kategori_layanan_entity.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_bloc.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_state.dart';
import 'service_grid_item.dart';

class ServiceCategoriesSection extends StatelessWidget {
  final VoidCallback? onLihatSemuaTap;
  final ValueChanged<String>? onCategoryTap;

  const ServiceCategoriesSection({
    super.key,
    this.onLihatSemuaTap,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jelajahi Layanan',
          style: TextStyle(
            color: AppColors.brandPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 32 / 24,
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<KategoriLayananBloc, KategoriLayananState>(
          builder: (context, state) {
            if (state.status == KategoriLayananStatus.loading ||
                state.status == KategoriLayananStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == KategoriLayananStatus.error) {
              return Center(
                child: Text(
                  'Gagal memuat kategori: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state.items.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada kategori layanan.',
                  style: TextStyle(color: AppColors.contentSecondary),
                ),
              );
            }

            return _buildCategoriesList(context, state.items);
          },
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: onLihatSemuaTap,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
            child: const Text(
              'Lihat semua',
              style: TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesList(
      BuildContext context,
      List<KategoriLayananEntity> items,
      ) {
    final rows = <List<KategoriLayananEntity>>[];

    for (int i = 0; i < items.length; i += 2) {
      rows.add([
        items[i],
        if (i + 1 < items.length) items[i + 1],
      ]);
    }

    return Column(
      children: rows.map((row) {
        final leftItem = row[0];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ServiceListItem(
                  title: leftItem.nama,
                  subtitle: '${leftItem.jumlahLayanan} Layanan',
                  onTap: () {
                    onCategoryTap?.call(leftItem.nama);
                  },
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: row.length > 1
                    ? ServiceListItem(
                  title: row[1].nama,
                  subtitle: '${row[1].jumlahLayanan} Layanan',
                  onTap: () {
                    onCategoryTap?.call(row[1].nama);
                  },
                )
                    : const SizedBox(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
