import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import 'notification_card.dart';

class NotificationContent extends StatefulWidget {
  const NotificationContent({super.key});

  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'all';
  String _query = '';
  bool _sortNewestFirst = true;

  int _currentPage = 1;
  final int _itemsPerPage = 5;

  final List<_NotificationItem> _items = [
    _NotificationItem(
      id: 'profile-updated',
      title: 'Profil Diperbaharui',
      message: 'Informasi profil Anda telah berhasil diperbarui.',
      timeLabel: '1 jam lalu',
      dateLabel: 'Hari ini',
      categoryKey: 'lainnya',
      categoryLabel: 'Lainnya',
      icon: Icons.info_outline_rounded,
      iconColor: Color(0xFF2563EB),
      iconBackgroundColor: Color(0xFFEFF6FF),
      isNew: true,
      createdAt: DateTime(2026, 3, 16, 13),
    ),
    _NotificationItem(
      id: 'document-needed',
      title: 'Dokumen Diperlukan',
      message:
      'Harap unggah dokumen tambahan untuk pengurusan akta kelahiran.',
      timeLabel: '3 jam lalu',
      dateLabel: 'Hari ini',
      categoryKey: 'layanan',
      categoryLabel: 'Layanan',
      icon: Icons.description_outlined,
      iconColor: Color(0xFF16A34A),
      iconBackgroundColor: Color(0xFFF0FDF4),
      isNew: true,
      createdAt: DateTime(2026, 3, 16, 11),
    ),
    _NotificationItem(
      id: 'system-update',
      title: 'Pembaruan Sistem',
      message:
      'Pemeliharaan terjadwal pada 15 Februari 2026 pukul 02:00 - 04:00 WIB.',
      timeLabel: '',
      dateLabel: 'Rabu, 15 Maret 2026',
      categoryKey: 'sistem',
      categoryLabel: 'Sistem',
      icon: Icons.settings_outlined,
      iconColor: Color(0xFF111827),
      iconBackgroundColor: Color(0xFFF9FAFB),
      isNew: false,
      createdAt: DateTime(2026, 3, 15, 9),
    ),
  ];

  List<FilterChipItem> get _chips {
    final chips = <FilterChipItem>[
      FilterChipItem(
        key: 'all',
        label: 'Semua',
        count: _countByFilter('all'),
      ),
      FilterChipItem(
        key: 'layanan',
        label: 'Layanan',
        count: _countByFilter('layanan'),
      ),
      FilterChipItem(
        key: 'sistem',
        label: 'Sistem',
        count: _countByFilter('sistem'),
      ),
      FilterChipItem(
        key: 'lainnya',
        label: 'Lainnya',
        count: _countByFilter('lainnya'),
      ),
    ];

    return chips.where((chip) {
      if (chip.key == 'all') {
        return true;
      }

      return chip.count > 0;
    }).toList();
  }

  List<_NotificationItem> get _filteredItems {
    final loweredQuery = _query.trim().toLowerCase();

    final filtered = _items.where((item) {
      final matchesFilter =
          _selectedFilter == 'all' || item.categoryKey == _selectedFilter;

      final matchesSearch = loweredQuery.isEmpty ||
          item.title.toLowerCase().contains(loweredQuery) ||
          item.message.toLowerCase().contains(loweredQuery) ||
          item.categoryLabel.toLowerCase().contains(loweredQuery);

      return matchesFilter && matchesSearch;
    }).toList();

    filtered.sort((a, b) {
      if (_sortNewestFirst) {
        return b.createdAt.compareTo(a.createdAt);
      }

      return a.createdAt.compareTo(b.createdAt);
    });

    return filtered;
  }

  int _countByFilter(String key) {
    if (key == 'all') {
      return _items.length;
    }

    return _items.where((item) => item.categoryKey == key).length;
  }

  int _getTotalPages(int totalItems) {
    if (totalItems == 0) {
      return 1;
    }

    return ((totalItems + _itemsPerPage - 1) / _itemsPerPage).floor();
  }

  List<_NotificationItem> _getPaginatedItems(
      List<_NotificationItem> items,
      int currentPage,
      ) {
    final startIndex = (currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    return items.sublist(
      startIndex,
      endIndex > items.length ? items.length : endIndex,
    );
  }

  Map<String, List<_NotificationItem>> _groupItemsByDate(
      List<_NotificationItem> items,
      ) {
    final groupedItems = <String, List<_NotificationItem>>{};

    for (final item in items) {
      groupedItems.putIfAbsent(item.dateLabel, () => []);
      groupedItems[item.dateLabel]!.add(item);
    }

    return groupedItems;
  }

  void _deleteNotification(String id) {
    setState(() {
      _items.removeWhere((item) => item.id == id);

      if (_selectedFilter != 'all' && _countByFilter(_selectedFilter) == 0) {
        _selectedFilter = 'all';
      }

      _currentPage = 1;
    });
  }

  void _onFilterSelected(String key) {
    setState(() {
      _selectedFilter = key;
      _currentPage = 1;
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.strokePrimary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 18),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Filter Notifikasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.contentPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                ..._chips.map((chip) {
                  final selected = _selectedFilter == chip.key;

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${chip.label} ${chip.count}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected
                            ? AppColors.brandPrimary
                            : AppColors.contentPrimary,
                      ),
                    ),
                    trailing: selected
                        ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.brandPrimary,
                    )
                        : null,
                    onTap: () {
                      _onFilterSelected(chip.key);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.strokePrimary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 18),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Urutkan Notifikasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.contentPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                _SortOptionTile(
                  title: 'Terbaru',
                  selected: _sortNewestFirst,
                  onTap: () {
                    setState(() {
                      _sortNewestFirst = true;
                      _currentPage = 1;
                    });

                    Navigator.pop(context);
                  },
                ),
                _SortOptionTile(
                  title: 'Terlama',
                  selected: !_sortNewestFirst,
                  onTap: () {
                    setState(() {
                      _sortNewestFirst = false;
                      _currentPage = 1;
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;
    final totalPages = _getTotalPages(filteredItems.length);
    final safeCurrentPage =
    _currentPage > totalPages ? totalPages : _currentPage;

    final paginatedItems = _getPaginatedItems(
      filteredItems,
      safeCurrentPage,
    );

    final groupedItems = _groupItemsByDate(paginatedItems);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BreadcrumbWidget(
            padding: EdgeInsets.zero,
            items: [
              BreadcrumbItem(label: 'Beranda'),
              BreadcrumbItem(label: 'Notifikasi'),
            ],
          ),

          const SizedBox(height: 18),

          _buildTitleCard(),

          const SizedBox(height: 16),

          _buildSearchField(),

          const SizedBox(height: 12),

          FilterSortRow(
            sortLabel: _sortNewestFirst ? 'Terbaru' : 'Terlama',
            onFilterTap: _showFilterSheet,
            onSortTap: _showSortSheet,
          ),

          const SizedBox(height: 16),

          FilterChipsRow(
            chips: _chips,
            selectedKey: _selectedFilter,
            onSelected: _onFilterSelected,
          ),

          const SizedBox(height: 16),

          if (filteredItems.isEmpty)
            _buildEmptyState()
          else ...[
            ...groupedItems.entries.expand((entry) {
              return [
                _DateLabel(text: entry.key),
                const SizedBox(height: 10),
                ...entry.value.map(
                      (item) {
                    return NotificationCard(
                      icon: item.icon,
                      iconColor: item.iconColor,
                      iconBackgroundColor: item.iconBackgroundColor,
                      title: item.title,
                      message: item.message,
                      timeLabel: item.timeLabel,
                      isNew: item.isNew,
                      onDelete: () {
                        _deleteNotification(item.id);
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
              ];
            }),

            if (totalPages > 1) ...[
              const SizedBox(height: 8),
              AppPagination(
                currentPage: safeCurrentPage,
                totalPages: totalPages,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildTitleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
      ),
      child: const Text(
        'Notifikasi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.contentPrimary,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _query = value;
            _currentPage = 1;
          });
        },
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.contentPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Cari notifikasi',
          hintStyle: const TextStyle(
            fontSize: 12,
            color: AppColors.contentSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 20,
            color: AppColors.contentSecondary,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: AppColors.strokePrimary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: AppColors.brandPrimary,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 36,
            color: AppColors.contentSecondary,
          ),
          SizedBox(height: 10),
          Text(
            'Tidak ada notifikasi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.contentPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final String dateLabel;
  final String categoryKey;
  final String categoryLabel;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool isNew;
  final DateTime createdAt;

  const _NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.dateLabel,
    required this.categoryKey,
    required this.categoryLabel,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.isNew,
    required this.createdAt,
  });
}

class _DateLabel extends StatelessWidget {
  final String text;

  const _DateLabel({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.contentPrimary,
        ),
      ),
    );
  }
}

class _SortOptionTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _SortOptionTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color:
          selected ? AppColors.brandPrimary : AppColors.contentPrimary,
        ),
      ),
      trailing: selected
          ? const Icon(
        Icons.check_circle_rounded,
        color: AppColors.brandPrimary,
      )
          : null,
      onTap: onTap,
    );
  }
}