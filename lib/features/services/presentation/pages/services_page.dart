import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_bloc.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_state.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_event.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import '../widgets/services_header.dart';
import '../widgets/service_category_list.dart';
import '../../../../shared/widgets/app_footer.dart';
import 'service_detail_page.dart';

class ServicesPage extends StatefulWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final VoidCallback? onServicesTap;
  final VoidCallback? onProfileTap;
  final bool isLoggedIn;

  const ServicesPage({
    super.key,
    this.onMenuTap,
    this.onLoginTap,
    this.onServicesTap,
    this.onProfileTap,
    this.isLoggedIn = false,
  });

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int _currentPage = 1;
  final int _totalPages = 4;
  String _selectedSort = 'Terbaru';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ServicesHeader(),
                  const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.strokePrimary),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: FilterSortRow(
                      sortLabel: _selectedSort,
                      onSortTap: () {
                        setState(() {
                          _selectedSort =
                          _selectedSort == 'Terbaru' ? 'Terlama' : 'Terbaru';
                        });
                      },
                    ),
                  ),
                  const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.strokePrimary),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: BlocProvider(
                      create: (_) => getIt<KategoriLayananBloc>()
                        ..add(const FetchKategoriLayanan()),
                      child: BlocBuilder<KategoriLayananBloc, KategoriLayananState>(
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
                              child: Text('Belum ada kategori layanan.'),
                            );
                          }
                          return ServiceCategoryList(
                            categories: state.items,
                            onServiceTap: (serviceTitle) {
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
                            },
                          );
                        },
                      ),
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
    );
  }
}
