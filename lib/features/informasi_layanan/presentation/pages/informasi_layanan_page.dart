import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/navigation/sidebar/app_drawer.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import '../bloc/informasi_layanan_bloc.dart';
import '../bloc/informasi_layanan_event.dart';
import '../bloc/informasi_layanan_state.dart';
import 'informasi_layanan_detail_page.dart';

class InformasiLayananPage extends StatefulWidget {
  final VoidCallback? onLoginTap;
  final VoidCallback? onBerandaTap;
  final VoidCallback? onAkunSayaTap;
  final VoidCallback? onKeluarAkunTap;
  final bool isLoggedIn;

  const InformasiLayananPage({
    super.key,
    this.onLoginTap,
    this.onBerandaTap,
    this.onAkunSayaTap,
    this.onKeluarAkunTap,
    this.isLoggedIn = false,
  });

  @override
  State<InformasiLayananPage> createState() => _InformasiLayananPageState();
}

class _InformasiLayananPageState extends State<InformasiLayananPage> {
  static const int _itemsPerPage = 10;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'all';
  String _selectedSort = 'Terbaru';
  int _currentPage = 1;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  void _closeDrawer() {
    final nav = Navigator.of(context);
    if (nav.canPop()) nav.pop();
  }

  void _popAndCall(BuildContext context, VoidCallback? callback) {
    final nav = Navigator.of(context);
    if (nav.canPop()) nav.pop();
    if (callback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => callback());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InformasiLayananBloc>()
        ..add(const FetchInformasiLayanan()),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: AppDrawer(
          isLoggedIn: widget.isLoggedIn,
          onBerandaTap: () => _popAndCall(context, widget.onBerandaTap),
          onInformasiLayananTap: _closeDrawer,
          onAkunSayaTap: () => _popAndCall(context, widget.onAkunSayaTap),
          onKeluarAkunTap: () => _popAndCall(context, widget.onKeluarAkunTap),
          onApiTestTap: () {
            Navigator.of(context).pushNamed(AppRouter.apiTest);
          },
        ),
        body: Column(
          children: [
            AppHeader(
              isLoggedIn: widget.isLoggedIn,
              onMenuTap: _openDrawer,
              onLoginTap: widget.onLoginTap,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BreadcrumbWidget(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      items: [
                        BreadcrumbItem(
                          label: 'Beranda',
                          onTap: () => _popAndCall(
                            context,
                            widget.onBerandaTap,
                          ),
                        ),
                        const BreadcrumbItem(label: 'Informasi Layanan'),
                      ],
                    ),
                    BlocBuilder<InformasiLayananBloc, InformasiLayananState>(
                      builder: (context, state) {
                        final allItems = state.items;
                        final filteredItems = _filteredItems(allItems);
                        final totalPages = filteredItems.isEmpty
                            ? 1
                            : ((filteredItems.length + _itemsPerPage - 1) ~/
                            _itemsPerPage);
                        final safeCurrentPage = _currentPage > totalPages
                            ? totalPages
                            : _currentPage;
                        final visibleItems = filteredItems
                            .skip((safeCurrentPage - 1) * _itemsPerPage)
                            .take(_itemsPerPage)
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _TitleCard(totalCount: allItems.length),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: _searchController,
                                onChanged: (_) {
                                  setState(() => _currentPage = 1);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Cari informasi',
                                  hintStyle: const TextStyle(
                                    color: AppColors.contentSecondary,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: AppColors.contentSecondary,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.backgroundSecondary,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.strokePrimary,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.strokePrimary,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.brandPrimary,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: FilterSortRow(
                                sortLabel: _selectedSort,
                                onSortTap: () {
                                  setState(() {
                                    _selectedSort = _selectedSort == 'Terbaru'
                                        ? 'Terlama'
                                        : 'Terbaru';
                                    _currentPage = 1;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: FilterChipsRow(
                                chips: _chipsFromItems(allItems),
                                selectedKey: _selectedFilter,
                                onSelected: (key) {
                                  setState(() {
                                    _selectedFilter = key;
                                    _currentPage = 1;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildContent(
                              context: context,
                              state: state,
                              allItems: allItems,
                              visibleItems: visibleItems,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: AppPagination(
                                currentPage: safeCurrentPage,
                                totalPages: totalPages,
                                onPageChanged: (page) {
                                  setState(() => _currentPage = page);
                                },
                              ),
                            ),
                            const SizedBox(height: 32),
                            const AppFooter(),
                          ],
                        );
                      },
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

  Widget _buildContent({
    required BuildContext context,
    required InformasiLayananState state,
    required List<dynamic> allItems,
    required List<dynamic> visibleItems,
  }) {
    if (state.status == InformasiLayananStatus.loading ||
        state.status == InformasiLayananStatus.initial) {
      return const _LoadingCard();
    }

    if (state.status == InformasiLayananStatus.error) {
      return _ErrorCard(message: state.errorMessage);
    }

    if (visibleItems.isEmpty) {
      return const _EmptyCard();
    }

    return Column(
      children: visibleItems.map((item) {
        final article = _articleMapFromItem(item);
        return _ArticleCard(
          category: article['category'] as String,
          publishedDate: article['publishedDate'] as String,
          title: article['title'] as String,
          description: article['description'] as String,
          imageUrl: article['imageUrl'] as String,
          likes: article['likes'] as String,
          comments: article['comments'] as String,
          onTap: () {
            final relatedArticles = allItems
                .where((relatedItem) => relatedItem != item)
                .map(_articleMapFromItem)
                .toList();

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return InformasiLayananDetailPage(
                    article: article,
                    relatedArticles: relatedArticles,
                    isLoggedIn: widget.isLoggedIn,
                    onLoginTap: widget.onLoginTap,
                    onBerandaTap: widget.onBerandaTap,
                    onAkunSayaTap: widget.onAkunSayaTap,
                    onKeluarAkunTap: widget.onKeluarAkunTap,
                  );
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }

  List<dynamic> _filteredItems(List<dynamic> items) {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = items.where((item) {
      final categoryKey = _categoryKey(_categoryId(item));
      final matchesFilter =
          _selectedFilter == 'all' || categoryKey == _selectedFilter;

      final title = _safeString(item.judul).toLowerCase();
      final description = _safeString(item.deskripsi).toLowerCase();
      final matchesSearch = query.isEmpty ||
          title.contains(query) ||
          description.contains(query) ||
          _categoryLabel(_categoryId(item)).toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();

    filtered.sort((a, b) {
      final aDate = _dateValue(a.dibuatPada);
      final bDate = _dateValue(b.dibuatPada);
      if (_selectedSort == 'Terlama') {
        return aDate.compareTo(bDate);
      }
      return bDate.compareTo(aDate);
    });

    return filtered;
  }

  List<FilterChipItem> _chipsFromItems(List<dynamic> items) {
    final counts = <String, _CategoryCount>{};

    for (final item in items) {
      final categoryId = _categoryId(item);
      final key = _categoryKey(categoryId);
      final label = _categoryLabel(categoryId);
      final current = counts[key];

      counts[key] = _CategoryCount(
        label: label,
        count: (current?.count ?? 0) + 1,
      );
    }

    final chips = <FilterChipItem>[
      FilterChipItem(key: 'all', label: 'Semua', count: items.length),
    ];

    counts.entries.toList()
      ..sort((a, b) => a.value.label.compareTo(b.value.label))
      ..forEach((entry) {
        chips.add(
          FilterChipItem(
            key: entry.key,
            label: entry.value.label,
            count: entry.value.count,
          ),
        );
      });

    return chips;
  }

  Map<String, dynamic> _articleMapFromItem(dynamic item) {
    final categoryId = _categoryId(item);
    final imageUrl = _safeString(item.thumbnailUrl).isNotEmpty
        ? _safeString(item.thumbnailUrl)
        : _safeString(item.imageUrl);
    final description = _safeString(item.deskripsi);

    return {
      'key': _categoryKey(categoryId),
      'category': _categoryLabel(categoryId),
      'publishedDate': _formatDate(item.dibuatPada),
      'title': _safeString(item.judul, fallback: 'Informasi Layanan'),
      'description': description,
      'imageUrl': imageUrl,
      'author': 'Admin INAKU',
      'editor': '-',
      'likes': '0',
      'comments': '0',
      'contentBlocks': [
        {
          'title': null,
          'body': description.isNotEmpty ? description : '-',
        },
      ],
    };
  }

  static int _categoryId(dynamic item) {
    final value = item.kategoriInformasiLayananId;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _categoryKey(int categoryId) {
    if (categoryId <= 0) return 'informasi';
    return 'kategori_$categoryId';
  }

  /// TODO: Ganti mapping ini ke nama kategori dari endpoint preload kategori
  /// informasi layanan kalau sudah tersedia di state/API.
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

  static DateTime _dateValue(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  static String _formatDate(dynamic value) {
    final date = _dateValue(value);
    if (date.millisecondsSinceEpoch == 0) return '-';

    try {
      return DateFormat('dd MMM yyyy', 'id_ID').format(date);
    } catch (_) {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  static String _safeString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }
}

class _CategoryCount {
  final String label;
  final int count;

  const _CategoryCount({
    required this.label,
    required this.count,
  });
}

class _TitleCard extends StatelessWidget {
  final int totalCount;

  const _TitleCard({required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.strokePrimary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Layanan',
              style: TextStyle(
                color: AppColors.brandPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$totalCount Informasi',
              style: const TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final String category;
  final String publishedDate;
  final String title;
  final String description;
  final String imageUrl;
  final String likes;
  final String comments;
  final VoidCallback onTap;

  const _ArticleCard({
    required this.category,
    required this.publishedDate,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.strokePrimary),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const _ImagePlaceholder(showLoading: true);
                },
                errorBuilder: (context, error, stackTrace) {
                  return const _ImagePlaceholder();
                },
              )
                  : const _ImagePlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: AppColors.brandPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 1,
                        height: 12,
                        color: AppColors.strokePrimary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Diterbitkan $publishedDate',
                        style: const TextStyle(
                          color: AppColors.contentSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 15,
                        color: AppColors.contentSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        likes,
                        style: const TextStyle(
                          color: AppColors.contentSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 15,
                        color: AppColors.contentSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        comments,
                        style: const TextStyle(
                          color: AppColors.contentSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final bool showLoading;

  const _ImagePlaceholder({this.showLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundSecondary,
      child: Center(
        child: showLoading
            ? const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.brandPrimary,
          ),
        )
            : const Icon(
          Icons.image_outlined,
          color: AppColors.contentSecondary,
          size: 40,
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.brandPrimary,
        ),
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
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
