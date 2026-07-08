import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ServiceDetailTabSection extends StatefulWidget {
  const ServiceDetailTabSection({
    super.key,
  });

  @override
  State<ServiceDetailTabSection> createState() {
    return _ServiceDetailTabSectionState();
  }
}

class _ServiceDetailTabSectionState
    extends State<ServiceDetailTabSection> {
  int _selectedTabIndex = 0;

  static const List<String> _tabs = [
    'Persyaratan',
    'Cara Mengakses',
    'Informasi Tambahan',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            _tabs.length,
                (index) {
              final isSelected = _selectedTabIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                      top: 10,
                      bottom: 11,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected
                              ? AppColors.brandPrimary
                              : AppColors.strokePrimary,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                    ),
                    child: Text(
                      _tabs[index],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.brandPrimary
                            : AppColors.contentSecondary,
                        fontSize: 12.5,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: KeyedSubtree(
            key: ValueKey(_selectedTabIndex),
            child: _TemporaryTabContent(
              onAccessGuideTap: () {
                setState(() {
                  _selectedTabIndex = 1;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TemporaryTabContent extends StatelessWidget {
  final VoidCallback onAccessGuideTap;

  const _TemporaryTabContent({
    required this.onAccessGuideTap,
  });

  static const List<String> _items = [
    'NIK orang tua.',
    'Kartu Keluarga (KK).',
    'Buku nikah atau akta perkawinan orang tua.',
    'Surat keterangan lahir dari rumah sakit, puskesmas, atau bidan.',
    'Jika NIK orang tua belum tersedia, sertakan Surat Pernyataan '
        'Tanggung Jawab Mutlak (SPTJM).',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Berikut adalah dokumen yang wajib disiapkan untuk '
              'pembuatan Akta Kelahiran anak:',
          style: TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          _items.length,
              (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _items.length - 1 ? 0 : 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F3F5),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: AppColors.contentSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _items[index],
                      style: const TextStyle(
                        color: AppColors.contentPrimary,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 18),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: onAccessGuideTap,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.brandPrimary,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Lihat cara mengakses',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}