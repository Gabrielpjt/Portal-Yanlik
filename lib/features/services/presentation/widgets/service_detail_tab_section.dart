import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/service_detail_entity.dart';

class ServiceDetailTabSection extends StatefulWidget {
  final List<ServiceOrderedItemEntity> persyaratan;
  final List<ServiceOrderedItemEntity> caraMengakses;
  final ServiceAdditionalInfoEntity? informasiTambahan;

  const ServiceDetailTabSection({
    super.key,
    required this.persyaratan,
    required this.caraMengakses,
    required this.informasiTambahan,
  });

  @override
  State<ServiceDetailTabSection> createState() {
    return _ServiceDetailTabSectionState();
  }
}

class _ServiceDetailTabSectionState extends State<ServiceDetailTabSection> {
  static const double _tabFontSize = 15;

  int _selectedTabIndex = 0;

  final List<GlobalKey> _tabKeys = List.generate(
    _tabs.length,
        (_) => GlobalKey(),
  );

  static const List<String> _tabs = [
    'Persyaratan',
    'Cara Mengakses',
    'Informasi Tambahan',
  ];

  void _selectTab(int index) {
    if (_selectedTabIndex == index) {
      return;
    }

    setState(() {
      _selectedTabIndex = index;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedContext = _tabKeys[index].currentContext;

      if (selectedContext == null) {
        return;
      }

      Scrollable.ensureVisible(
        selectedContext,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        alignment: 0.5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ScrollableTabHeader(
          tabs: _tabs,
          tabKeys: _tabKeys,
          selectedIndex: _selectedTabIndex,
          fontSize: _tabFontSize,
          onSelected: _selectTab,
        ),
        const SizedBox(height: 18),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: KeyedSubtree(
            key: ValueKey(_selectedTabIndex),
            child: _selectedContent,
          ),
        ),
      ],
    );
  }

  Widget get _selectedContent {
    if (_selectedTabIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _OrderedListContent(
            items: widget.persyaratan,
            emptyText: 'Belum ada persyaratan untuk layanan ini.',
          ),
          if (widget.caraMengakses.isNotEmpty) ...[
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _selectTab(1),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.brandPrimary,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lihat cara mengakses',
                      style: TextStyle(
                        fontSize: 14,
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
        ],
      );
    }

    if (_selectedTabIndex == 1) {
      return _OrderedListContent(
        items: widget.caraMengakses,
        emptyText: 'Belum ada cara mengakses untuk layanan ini.',
      );
    }

    return _AdditionalInfoContent(
      info: widget.informasiTambahan,
    );
  }
}

class _ScrollableTabHeader extends StatelessWidget {
  final List<String> tabs;
  final List<GlobalKey> tabKeys;
  final int selectedIndex;
  final double fontSize;
  final ValueChanged<int> onSelected;

  const _ScrollableTabHeader({
    required this.tabs,
    required this.tabKeys,
    required this.selectedIndex,
    required this.fontSize,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.strokePrimary,
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedIndex == index;

            return Padding(
              padding: EdgeInsets.only(
                right: index == tabs.length - 1 ? 2 : 22,
              ),
              child: _DetailTabButton(
                key: tabKeys[index],
                label: tabs[index],
                isSelected: isSelected,
                fontSize: fontSize,
                onTap: () => onSelected(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _DetailTabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final double fontSize;
  final VoidCallback onTap;

  const _DetailTabButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.fromLTRB(2, 11, 2, 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.brandPrimary : Colors.transparent,
                width: 2.4,
              ),
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: isSelected
                  ? AppColors.brandPrimary
                  : AppColors.contentSecondary,
              fontSize: fontSize,
              height: 1.2,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderedListContent extends StatelessWidget {
  final List<ServiceOrderedItemEntity> items;
  final String emptyText;

  const _OrderedListContent({
    required this.items,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Text(
        emptyText,
        style: const TextStyle(
          color: AppColors.contentSecondary,
          fontSize: 14,
          height: 1.5,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        items.length,
            (index) {
          final item = items[index];
          final title = item.judul.trim();
          final description = item.deskripsi.trim();

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == items.length - 1 ? 0 : 14,
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
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _OrderedText(
                    title: title,
                    description: description,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OrderedText extends StatelessWidget {
  final String title;
  final String description;

  const _OrderedText({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (title.isEmpty && description.isEmpty) {
      return const Text(
        '-',
        style: TextStyle(
          color: AppColors.contentPrimary,
          fontSize: 14,
          height: 1.5,
        ),
      );
    }

    if (title.isEmpty || title == description) {
      return Text(
        description.isNotEmpty ? description : title,
        style: const TextStyle(
          color: AppColors.contentPrimary,
          fontSize: 14,
          height: 1.5,
        ),
      );
    }

    if (description.isEmpty) {
      return Text(
        title,
        style: const TextStyle(
          color: AppColors.contentPrimary,
          fontSize: 14,
          height: 1.5,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 14,
            height: 1.45,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          description,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _AdditionalInfoContent extends StatelessWidget {
  final ServiceAdditionalInfoEntity? info;

  const _AdditionalInfoContent({
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return const Text(
        'Belum ada informasi tambahan untuk layanan ini.',
        style: TextStyle(
          color: AppColors.contentSecondary,
          fontSize: 14,
          height: 1.5,
        ),
      );
    }

    final items = <MapEntry<String, String>>[
      MapEntry('Biaya Layanan', info!.biayaLayanan.trim()),
      MapEntry('Hasil Layanan', info!.hasilLayanan.trim()),
      MapEntry('Waktu Penyelesaian', info!.waktuPenyelesaian.trim()),
    ].where((item) => item.value.isNotEmpty).toList();

    if (items.isEmpty) {
      return const Text(
        'Belum ada informasi tambahan untuk layanan ini.',
        style: TextStyle(
          color: AppColors.contentSecondary,
          fontSize: 14,
          height: 1.5,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        items.length,
            (index) {
          final item = items[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == items.length - 1 ? 0 : 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.key,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
