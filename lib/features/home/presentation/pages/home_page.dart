import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/popular_topics_section.dart';
import '../widgets/service_categories_section.dart';
import '../widgets/latest_info_section.dart';
import '../widgets/home_benefit_section.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../benefit/presentation/pages/benefit_page.dart';
import '../../../services/presentation/pages/service_detail_page.dart';
import '../widgets/service_grid_item.dart';
import '../../../informasi_layanan/presentation/bloc/informasi_layanan_bloc.dart';
import '../../../informasi_layanan/presentation/bloc/informasi_layanan_event.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_bloc.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_event.dart';
import '../../../layanan/presentation/bloc/layanan_bloc.dart';
import '../../../layanan/presentation/bloc/layanan_event.dart';
import '../../../layanan/presentation/bloc/layanan_state.dart';
import '../../../layanan/domain/entities/layanan_entity.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final bool isLoggedIn;
  final VoidCallback? onServicesTap;
  final VoidCallback? onEdokumenTap;
  final VoidCallback? onAkunSayaTap;
  final VoidCallback? onKeluarAkunTap;

  const HomePage({
    super.key,
    this.onMenuTap,
    this.onLoginTap,
    this.onServicesTap,
    this.onEdokumenTap,
    this.onAkunSayaTap,
    this.onKeluarAkunTap,
    this.isLoggedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppHeader(
            onMenuTap: onMenuTap,
            onLoginTap: onLoginTap,
            isLoggedIn: isLoggedIn,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        const SearchBarWidget(),
                        const SizedBox(height: 24),

                        // ── Benefit & E-Dokumen (saat login) ─────────────
                        if (isLoggedIn) ...[
                          HomeBenefitSection(
                            onLihatSemuaBenefit: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BenefitPage(
                                    isLoggedIn: isLoggedIn,
                                    onLoginTap: onLoginTap,
                                    onBerandaTap: () {},
                                    onAkunSayaTap: onAkunSayaTap,
                                    onKeluarAkunTap: onKeluarAkunTap,
                                  ),
                                ),
                              );
                            },
                            onLihatSemuaDokumen: onEdokumenTap,
                          ),
                          const SizedBox(height: 28),
                        ],

                        // ── Layanan Populer ──────────────────────────────
                        const Text(
                          'Layanan Populer',
                          style: TextStyle(
                            color: AppColors.brandPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 32 / 24,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Layanan Populer Nasional',
                          style: TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 18,
                            height: 24 / 18,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // 2-column list with dynamic items
                        BlocProvider(
                          create: (_) => getIt<LayananBloc>()..add(const FetchLayanan()),
                          child: BlocBuilder<LayananBloc, LayananState>(
                            builder: (context, state) {
                              if (state.status == LayananStatus.loading ||
                                  state.status == LayananStatus.initial) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (state.status == LayananStatus.error) {
                                return Center(
                                  child: Text(
                                    'Gagal memuat layanan: ${state.errorMessage}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              }
                              if (state.items.isEmpty) {
                                return const Center(
                                  child: Text('Belum ada layanan populer.'),
                                );
                              }
                              // Limit to 6 items to match UI design if preferred, or show all
                              final displayItems = state.items.take(6).toList();
                              return _buildPopularServicesList(context, displayItems);
                            },
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Lihat Semua button — outlined full width
                        _buildLihatSemuaButton(),
                        const SizedBox(height: 32),
                        const PopularTopicsSection(),
                        const SizedBox(height: 32),
                        BlocProvider(
                          create: (_) => getIt<KategoriLayananBloc>()
                            ..add(const FetchKategoriLayanan()),
                          child: const ServiceCategoriesSection(),
                        ),
                        const SizedBox(height: 32),
                        BlocProvider(
                          create: (_) => getIt<InformasiLayananBloc>()
                            ..add(const FetchInformasiLayanan()),
                          child: const LatestInfoSection(),
                        ),
                        const SizedBox(height: 32),
                      ],
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

  Widget _buildPopularServicesList(BuildContext context, List<LayananEntity> items) {
    final rows = <List<LayananEntity>>[];

    for (int i = 0; i < items.length; i += 2) {
      rows.add([
        items[i],
        if (i + 1 < items.length) items[i + 1],
      ]);
    }

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ServiceListItem(
                  title: row[0].nama,
                  onTap: () {
                    _openServiceDetail(
                      context,
                      serviceTitle: row[0].nama,
                    );
                  },
                ),
              ),

              const SizedBox(width: 24),

              Expanded(
                child: row.length > 1
                    ? ServiceListItem(
                        title: row[1].nama,
                        onTap: () {
                          _openServiceDetail(
                            context,
                            serviceTitle: row[1].nama,
                          );
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

  Widget _buildLihatSemuaButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.strokePrimary, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: const Center(
            child: Text(
              'Lihat semua',
              style: TextStyle(
                color: AppColors.brandPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _openServiceDetail(
      BuildContext context, {
        required String serviceTitle,
      }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceDetailPage(
          serviceTitle: serviceTitle,
          isLoggedIn: isLoggedIn,
          onMenuTap: onMenuTap,
          onLoginTap: onLoginTap,
          onServicesTap: onServicesTap,
        ),
      ),
    );
  }
}
