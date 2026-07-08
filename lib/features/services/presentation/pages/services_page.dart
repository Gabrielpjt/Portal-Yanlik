import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
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

  /// Dipakai untuk navigasi dari menu/home agar langsung scroll ke kategori.
  final String? initialCategory;

  /// Ubah nilai ini saat request scroll baru dengan kategori yang sama.
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
  int _currentPage = 1;
  final int _totalPages = 4;
  String _selectedSort = 'Terbaru';

  final ScrollController _scrollController = ScrollController();

  /// Key dibuat dinamis dari kategori API, tapi tetap disimpan agar bisa
  /// dipakai Scrollable.ensureVisible ketika navigasi ke kategori tertentu.
  final Map<String, GlobalKey> _categoryKeys = <String, GlobalKey>{};

  @override
  void initState() {
    super.initState();
    _scheduleScrollToCategory(widget.initialCategory);
  }

  @override
  void didUpdateWidget(covariant ServicesPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollRequestId != widget.scrollRequestId ||
        oldWidget.initialCategory != widget.initialCategory) {
      _scheduleScrollToCategory(widget.initialCategory);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        // Data kategori mungkin belum selesai load. Coba lagi setelah frame
        // berikutnya, biasanya setelah BlocBuilder selesai render.
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

  void _openServiceDetail(String serviceTitle) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceDetailPage(
          serviceTitle: serviceTitle,
          isLoggedIn: widget.isLoggedIn,
          onMenuTap: widget.onMenuTap,
          onLoginTap: widget.onLoginTap,
          onServicesTap: widget.onServicesTap,
        ),
      ),
    );
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
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ServicesHeader(),
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
                        onSortTap: () {
                          setState(() {
                            _selectedSort = _selectedSort == 'Terbaru'
                                ? 'Terlama'
                                : 'Terbaru';
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
                      child: BlocBuilder<KategoriLayananBloc,
                          KategoriLayananState>(
                        builder: (context, state) {
                          if (state.status == KategoriLayananStatus.loading ||
                              state.status == KategoriLayananStatus.initial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
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
                              child: Text('Belum ada kategori layanan.'),
                            );
                          }

                          _syncCategoryKeys(
                            state.items.map((item) => item.nama).toList(),
                          );

                          _scheduleScrollToCategory(widget.initialCategory);

                          return ServiceCategoryList(
                            categories: state.items,
                            categoryKeys: _categoryKeys,
                            onServiceTap: _openServiceDetail,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: AppPagination(
                        currentPage: _currentPage,
                        totalPages: _totalPages,
                        onPageChanged: (page) {
                          setState(() => _currentPage = page);
                        },
                      ),
                    ),
                    const AppFooter(),
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
