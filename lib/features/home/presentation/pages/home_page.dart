import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';

import '../widgets/home_benefit_section.dart';
import '../widgets/latest_info_section.dart';
import '../widgets/popular_topics_section.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/service_categories_section.dart';
import '../widgets/service_grid_item.dart';

import '../../../benefit/presentation/pages/benefit_detail_page.dart';
import '../../../benefit/presentation/pages/benefit_page.dart';
import '../../../profile/presentation/pages/document_detail_page.dart';
import '../../../services/presentation/pages/service_detail_page.dart';

import '../../../informasi_layanan/presentation/bloc/informasi_layanan_bloc.dart';
import '../../../informasi_layanan/presentation/bloc/informasi_layanan_event.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_bloc.dart';
import '../../../kategori_layanan/presentation/bloc/kategori_layanan_event.dart';
import '../../../layanan/domain/entities/layanan_entity.dart';
import '../../../layanan/presentation/bloc/layanan_bloc.dart';
import '../../../layanan/presentation/bloc/layanan_event.dart';
import '../../../layanan/presentation/bloc/layanan_state.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final bool isLoggedIn;
  final VoidCallback? onServicesTap;
  final VoidCallback? onEdokumenTap;
  final VoidCallback? onAkunSayaTap;
  final VoidCallback? onKeluarAkunTap;
  final ValueChanged<String>? onServiceCategoryTap;
  final VoidCallback? onInformasiLayananTap;

  const HomePage({
    super.key,
    this.onMenuTap,
    this.onLoginTap,
    this.onServicesTap,
    this.onEdokumenTap,
    this.onAkunSayaTap,
    this.onKeluarAkunTap,
    this.onServiceCategoryTap,
    this.onInformasiLayananTap,
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

                        if (isLoggedIn) ...[
                          HomeBenefitSection(
                            onBenefitTap: (benefitName) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BenefitDetailPage(
                                      benefitTitle: benefitName,
                                      isLoggedIn: isLoggedIn,
                                      onLoginTap: onLoginTap,
                                      onBerandaTap: () {},
                                      onAkunSayaTap: onAkunSayaTap,
                                      onKeluarAkunTap: onKeluarAkunTap,
                                    );
                                  },
                                ),
                              );
                            },
                            onDocumentTap: (
                                documentName,
                                category,
                                number,
                                verified,
                                ) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return DocumentDetailPage(
                                      onMenuTap: onMenuTap,
                                      document: DocumentData(
                                        title: documentName,
                                        validUntil: '31 Des 2026',
                                        isVerified: verified,
                                        ownerName: 'Ayu Lestari',
                                        ownerRole: 'Kepala keluarga',
                                        documentNumber: number,
                                        issueDate: '12 Jan 2026',
                                        issuedBy:
                                        'Dinas Kependudukan dan Pencatatan Sipil',
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            onLihatSemuaBenefit: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BenefitPage(
                                      isLoggedIn: isLoggedIn,
                                      onLoginTap: onLoginTap,
                                      onBerandaTap: () {},
                                      onAkunSayaTap: onAkunSayaTap,
                                      onKeluarAkunTap: onKeluarAkunTap,
                                    );
                                  },
                                ),
                              );
                            },
                            onLihatSemuaDokumen: onEdokumenTap,
                          ),
                          const SizedBox(height: 28),
                        ],

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

                        BlocProvider(
                          create: (_) {
                            return getIt<LayananBloc>()
                              ..add(const FetchLayanan());
                          },
                          child: BlocBuilder<LayananBloc, LayananState>(
                            builder: (context, state) {
                              if (state.status == LayananStatus.loading ||
                                  state.status == LayananStatus.initial) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              if (state.status == LayananStatus.error) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: Text(
                                      'Gagal memuat layanan: ${state.errorMessage}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final displayItems = _buildPopularServiceItems(
                                state.items,
                              );

                              if (displayItems.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: Text('Belum ada layanan populer.'),
                                  ),
                                );
                              }

                              return _buildPopularServicesList(
                                context,
                                displayItems,
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 12),
                        _buildLihatSemuaButton(),
                        const SizedBox(height: 32),

                        const PopularTopicsSection(),
                        const SizedBox(height: 32),

                        BlocProvider(
                          create: (_) {
                            return getIt<KategoriLayananBloc>()
                              ..add(const FetchKategoriLayanan());
                          },
                          child: ServiceCategoriesSection(
                            onLihatSemuaTap: onServicesTap,
                            onCategoryTap: onServiceCategoryTap,
                          ),
                        ),

                        const SizedBox(height: 32),

                        BlocProvider(
                          create: (_) {
                            return getIt<InformasiLayananBloc>()
                              ..add(const FetchInformasiLayanan());
                          },
                          child: LatestInfoSection(
                            onLihatSemuaTap: onInformasiLayananTap,
                            onCardTap: onInformasiLayananTap,
                          ),
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

  List<_PopularServiceItem> _buildPopularServiceItems(
      List<LayananEntity> items,
      ) {
    final services = <_PopularServiceItem>[];

    for (final item in items) {
      final title = item.nama.trim();

      if (title.isEmpty) {
        continue;
      }

      final alreadyAdded = services.any(
            (existingItem) =>
        existingItem.title.toLowerCase() == title.toLowerCase(),
      );

      if (alreadyAdded) {
        continue;
      }

      services.add(
        _PopularServiceItem(
          id: item.id,
          title: title,
        ),
      );

      if (services.length >= 6) {
        break;
      }
    }

    return services;
  }

  Widget _buildPopularServicesList(
      BuildContext context,
      List<_PopularServiceItem> serviceItems,
      ) {
    final rows = <List<_PopularServiceItem>>[];

    for (int i = 0; i < serviceItems.length; i += 2) {
      rows.add([
        serviceItems[i],
        if (i + 1 < serviceItems.length) serviceItems[i + 1],
      ]);
    }

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ServiceListItem(
                  title: row[0].title,
                  onTap: () {
                    _openServiceDetail(
                      context,
                      serviceTitle: row[0].title,
                      serviceId: row[0].id,
                    );
                  },
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: row.length > 1
                    ? ServiceListItem(
                  title: row[1].title,
                  onTap: () {
                    _openServiceDetail(
                      context,
                      serviceTitle: row[1].title,
                      serviceId: row[1].id,
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
        border: Border.all(
          color: AppColors.strokePrimary,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onServicesTap,
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
        int? serviceId,
      }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ServiceDetailPage(
            serviceId: serviceId,
            serviceTitle: serviceTitle,
            isLoggedIn: isLoggedIn,
            onMenuTap: onMenuTap,
            onLoginTap: onLoginTap,
            onServicesTap: onServicesTap,
          );
        },
      ),
    );
  }
}

class _PopularServiceItem {
  final int? id;
  final String title;

  const _PopularServiceItem({
    required this.title,
    this.id,
  });
}
