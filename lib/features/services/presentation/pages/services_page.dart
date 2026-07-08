import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import '../../../kategori_layanan/domain/entities/kategori_layanan_entity.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_bloc.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_event.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_state.dart';
import '../widgets/service_category_list.dart';
import '../widgets/services_header.dart';
import 'service_detail_page.dart';

class ServicesPage extends StatefulWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final VoidCallback? onServicesTap;
  final VoidCallback? onProfileTap;
  final bool isLoggedIn;
  final String? initialCategory;
  final int scrollRequestId;

  const ServicesPage({
    super.key,
    this.onMenuTap,
    this.onLoginTap,
    this.onServicesTap,
    this.onProfileTap,
    this.isLoggedIn = false,
    this.initialCategory,
    this.scrollRequestId = 0,
  });

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String _selectedSort = 'A-Z';
  String _selectedCategoryKey = 'all';
  String _searchKeyword = '';

  final ScrollController _scrollController = ScrollController();

  final Map<String, GlobalKey> _categoryKeys = <String, GlobalKey>{};

  @override
  void initState() {
    super.initState();
    _selectedCategoryKey = widget.initialCategory?.trim().isNotEmpty == true
        ? widget.initialCategory!.trim()
        : 'all';
    _scheduleScrollToCategory(widget.initialCategory);
  }

  @override
  void didUpdateWidget(covariant ServicesPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollRequestId != widget.scrollRequestId ||
        oldWidget.initialCategory != widget.initialCategory) {
      final categoryName = widget.initialCategory?.trim();

      if (categoryName != null && categoryName.isNotEmpty) {
        setState(() {
          _selectedCategoryKey = categoryName;
        });
      }

      _scheduleScrollToCategory(widget.initialCategory);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _sortAscending => _selectedSort == 'A-Z';

  GlobalKey _keyForCategory(String categoryName) {
    return _categoryKeys.putIfAbsent(categoryName, () => GlobalKey());
  }

  void _syncCategoryKeys(List<String> categoryNames) {
    for (final categoryName in categoryNames) {
      _keyForCategory(categoryName);
    }

    _categoryKeys.removeWhere(
          (key, _) => !categoryNames.contains(key),
    );
  }

  void _scheduleScrollToCategory(String? categoryName) {
    if (categoryName == null || categoryName.trim().isEmpty) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final targetContext = _categoryKeys[categoryName]?.currentContext;

      if (targetContext == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }

          final retryContext = _categoryKeys[categoryName]?.currentContext;
          if (retryContext == null) {
            return;
          }

          _scrollToContext(retryContext);
        });
        return;
      }

      _scrollToContext(targetContext);
    });
  }

  void _scrollToContext(BuildContext targetContext) {
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      alignment: 0.08,
    );
  }

  void _openServiceDetail(int serviceId, String serviceTitle) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceDetailPage(
          serviceId: serviceId,
          serviceTitle: serviceTitle,
          isLoggedIn: widget.isLoggedIn,
          onMenuTap: widget.onMenuTap,
          onLoginTap: widget.onLoginTap,
          onServicesTap: widget.onServicesTap,
        ),
      ),
    );
  }

  int _totalNamedServices(List<KategoriLayananEntity> categories) {
    var total = 0;

    for (final category in categories) {
      for (final layanan in category.layanan) {
        final name = layanan.nama.trim();
        if (name.isEmpty || name.toLowerCase() == 'tanpa nama') {
          continue;
        }
        total++;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<KategoriLayananBloc>()
        ..add(const FetchKategoriLayanan()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            AppHeader(
              onMenuTap: widget.onMenuTap,
              onLoginTap: widget.onLoginTap,
              isLoggedIn: widget.isLoggedIn,
            ),
            Expanded(
              child: BlocBuilder<KategoriLayananBloc, KategoriLayananState>(
                builder: (context, state) {
                  final categories = state.items;
                  final totalLayanan = _totalNamedServices(categories);

                  if (categories.isNotEmpty) {
                    _syncCategoryKeys(
                      categories.map((item) => item.nama).toList(),
                    );
                    _scheduleScrollToCategory(widget.initialCategory);
                  }

                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ServicesHeader(
                          totalLayanan: totalLayanan,
                          onSearchChanged: (value) {
                            setState(() {
                              _searchKeyword = value;
                            });
                          },
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.strokePrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: FilterSortRow(
                            sortLabel: _selectedSort,
                            onFilterTap: () {
                              setState(() {
                                _selectedCategoryKey = 'all';
                                _searchKeyword = '';
                              });
                            },
                            onSortTap: () {
                              setState(() {
                                _selectedSort = _selectedSort == 'A-Z'
                                    ? 'Z-A'
                                    : 'A-Z';
                              });
                            },
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.strokePrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: _buildCategoryContent(state),
                        ),
                        const AppFooter(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent(KategoriLayananState state) {
    if (state.status == KategoriLayananStatus.loading ||
        state.status == KategoriLayananStatus.initial) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 28),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.status == KategoriLayananStatus.error) {
      return Center(
        child: Text(
          'Gagal memuat kategori: ${state.errorMessage}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state.items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 28),
          child: Text('Belum ada kategori layanan.'),
        ),
      );
    }

    return ServiceCategoryList(
      categories: state.items,
      categoryKeys: _categoryKeys,
      selectedCategoryKey: _selectedCategoryKey,
      searchKeyword: _searchKeyword,
      sortAscending: _sortAscending,
      onCategorySelected: (key) {
        setState(() {
          _selectedCategoryKey = key;
        });

        if (key != 'all') {
          _scheduleScrollToCategory(key);
        }
      },
      onServiceTap: _openServiceDetail,
    );
  }
}
