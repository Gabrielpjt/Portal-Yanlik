import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import 'service_access_common_widgets.dart';

class BpomProductItem {
  final String productName;
  final String registrationNumber;
  final String issuedDate;
  final String validUntil;
  final String brand;
  final String type;
  final String packaging;
  final String registrant;
  final String location;
  final String categoryKey;

  const BpomProductItem({
    required this.productName,
    required this.registrationNumber,
    required this.issuedDate,
    required this.validUntil,
    required this.brand,
    required this.type,
    required this.packaging,
    required this.registrant,
    required this.location,
    required this.categoryKey,
  });
}

class BpomProductInitialState extends StatelessWidget {
  const BpomProductInitialState({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceAccessSearchEmptyState(
      title: 'Pengecekan Produk BPOM',
      description:
      'Lakukan pengecekan produk BPOM dengan memasukkan nama produk, '
          'kode NIE, dan nama pendaftar.',
      icon: _BpomProductDocumentSearchIcon(),
      height: 310,
    );
  }
}

class _BpomProductDocumentSearchIcon extends StatelessWidget {
  const _BpomProductDocumentSearchIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 2,
            top: 0,
            child: Icon(
              Icons.description_outlined,
              size: 30,
              color: Color(0xFF062F5E),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 2,
            child: Container(
              width: 17,
              height: 17,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search,
                size: 14,
                color: Color(0xFF062F5E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BpomProductNoResultState extends StatelessWidget {
  const BpomProductNoResultState({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceAccessSearchEmptyState(
      title: 'Hasil tidak ditemukan',
      description: 'Gunakan kata kunci pencarian lainnya.',
      icon: Icon(
        Icons.search,
        size: 26,
        color: Color(0xFF062F5E),
      ),
      height: 330,
    );
  }
}

class BpomProductSearchResults extends StatelessWidget {
  final String keyword;
  final List<BpomProductItem> products;
  final String selectedCategoryKey;
  final int allCount;
  final int cosmeticCount;
  final int currentPage;
  final int totalPages;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;

  const BpomProductSearchResults({
    super.key,
    required this.keyword,
    required this.products,
    required this.selectedCategoryKey,
    required this.allCount,
    required this.cosmeticCount,
    required this.currentPage,
    required this.totalPages,
    required this.onCategorySelected,
    required this.onPageChanged,
    required this.onFilterTap,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menampilkan hasil pencarian untuk',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF777777),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          keyword,
          style: const TextStyle(
            fontSize: 15,
            height: 1.35,
            fontWeight: FontWeight.w700,
            color: Color(0xFF252525),
          ),
        ),
        const SizedBox(height: 18),
        FilterSortRow(
          sortLabel: 'Terbaru',
          onFilterTap: onFilterTap,
          onSortTap: onSortTap,
        ),
        const SizedBox(height: 18),
        FilterChipsRow(
          chips: [
            FilterChipItem(
              key: 'all',
              label: 'Semua',
              count: allCount,
            ),
            FilterChipItem(
              key: 'cosmetic',
              label: 'Kosmetik',
              count: cosmeticCount,
            ),
          ],
          selectedKey: selectedCategoryKey,
          onSelected: onCategorySelected,
        ),
        const SizedBox(height: 24),
        ListView.separated(
          itemCount: products.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return BpomProductCard(
              product: products[index],
            );
          },
        ),
        if (totalPages > 1) ...[
          const SizedBox(height: 24),
          AppPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: onPageChanged,
          ),
        ],
        const SizedBox(height: 28),
      ],
    );
  }
}

class BpomProductCard extends StatelessWidget {
  final BpomProductItem product;
  final VoidCallback? onTap;

  const BpomProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE5E5E5),
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.3,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF252525),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.north_east,
                    size: 18,
                    color: Color(0xFF062F5E),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      product.registrationNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.35,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Color(0xFF279A4B),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _BpomProductInfoRow(
                label: 'Terbit',
                value: product.issuedDate,
              ),
              const SizedBox(height: 12),
              _BpomProductInfoRow(
                label: 'Masa berlaku',
                value: product.validUntil,
              ),
              const SizedBox(height: 12),
              _BpomProductInfoRow(
                label: 'Merek',
                value: product.brand,
              ),
              const SizedBox(height: 12),
              _BpomProductInfoRow(
                label: 'Tipe',
                value: product.type,
              ),
              const SizedBox(height: 12),
              _BpomProductInfoRow(
                label: 'Kemasan',
                value: product.packaging,
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE7E7E7),
              ),
              const SizedBox(height: 16),
              Text(
                product.registrant,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF252525),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product.location,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BpomProductInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _BpomProductInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 118,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              color: Color(0xFF666666),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w600,
              color: Color(0xFF252525),
            ),
          ),
        ),
      ],
    );
  }
}
