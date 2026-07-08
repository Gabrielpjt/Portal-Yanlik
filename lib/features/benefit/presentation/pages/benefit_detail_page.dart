import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/navigation/sidebar/app_drawer.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../../../shared/widgets/helpful_review_section.dart';
import '../widgets/benefit_detail_overview_card.dart';
import '../widgets/benefit_detail_sections.dart';

class BenefitDetailPage extends StatefulWidget {
  final String benefitTitle;
  final bool isLoggedIn;
  final VoidCallback? onLoginTap;
  final VoidCallback? onBerandaTap;
  final VoidCallback? onAkunSayaTap;
  final VoidCallback? onKeluarAkunTap;

  const BenefitDetailPage({
    super.key,
    required this.benefitTitle,
    this.isLoggedIn = true,
    this.onLoginTap,
    this.onBerandaTap,
    this.onAkunSayaTap,
    this.onKeluarAkunTap,
  });

  @override
  State<BenefitDetailPage> createState() {
    return _BenefitDetailPageState();
  }
}

class _BenefitDetailPageState extends State<BenefitDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final _BenefitDetailData _data;

  @override
  void initState() {
    super.initState();
    _data = _getDetailData(widget.benefitTitle);
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _popAndCall(BuildContext context, VoidCallback? callback) {
    final nav = Navigator.of(context);

    if (nav.canPop()) {
      nav.pop();
    }

    if (callback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    }
  }

  _BenefitDetailData _getDetailData(String title) {
    switch (title) {
      case 'Bantuan Pangan Non Tunai':
        return _BenefitDetailData(
          title: 'Bantuan Pangan Non Tunai',
          statusDate: '25 Feb 2026',
          statusLabel: 'Aktif',
          summaryItems: const [
            BenefitSummaryInfo(
              label: 'Kategori',
              value: 'Ibu Hamil',
              caption: 'Rp. 750.000 / Triwulan',
              showCurrencyPrefix: false,
            ),
            BenefitSummaryInfo(
              label: 'Total Pencairan 2026',
              value: '1.500.000',
              caption: '2 kali pencairan',
            ),
            BenefitSummaryInfo(
              label: 'Pencairan Berikutnya',
              value: '750.000',
              caption: 'Estimasi Sep 2026',
            ),
          ],
          description:
          'Saldo elektronik bulanan untuk membeli bahan pangan pokok di e-warong, agen, atau mitra bank yang ditunjuk. Berikut adalah informasi bahan pangan yang bisa dibeli:\n'
              '• Beras SPHP / Beras premium\n'
              '• Telur ayam ras\n'
              '• Tempe / Tahu (di mitra tertentu)\n'
              '• Sayur & buah segar (di mitra tertentu)',
          breakdownItems: const [],
          historyTitle: 'Riwayat Transaksi',
          historyItems: const [
            BenefitTimelineItem(
              title: 'Top Up -',
              description: '01 Apr 2026 - Otomatis',
              amount: 'Sebesar Rp. 200.000',
            ),
            BenefitTimelineItem(
              title: 'Belanja -',
              description: '12 Mar 2026 - Beras 5 Kg + Telur 1 Kg',
              amount: 'Sebesar Rp. 50.000',
            ),
            BenefitTimelineItem(
              title: 'Top Up -',
              description: '01 Mar 2026 - Otomatis',
              amount: 'Sebesar Rp. 200.000',
            ),
          ],
        );

      case 'Program Keluarga Harapan':
      default:
        return _BenefitDetailData(
          title: 'Program Keluarga Harapan',
          statusDate: '25 Feb 2026',
          statusLabel: 'Aktif',
          summaryItems: const [
            BenefitSummaryInfo(
              label: 'Kategori',
              value: 'Ibu Hamil',
              caption: 'Rp. 750.000 / Triwulan',
              showCurrencyPrefix: false,
            ),
            BenefitSummaryInfo(
              label: 'Total Pencairan 2026',
              value: '1.500.000',
              caption: '2 kali pencairan',
            ),
            BenefitSummaryInfo(
              label: 'Pencairan Berikutnya',
              value: '750.000',
              caption: 'Estimasi Sep 2026',
            ),
          ],
          description:
          'Bantuan sosial bersyarat untuk keluarga kurang mampu yang terdaftar sebagai KPM (Keluarga Penerima Manfaat).',
          breakdownDescription:
          'Berikut adalah komponen bantuan yang diterima:',
          breakdownItems: const [
            BenefitBreakdownItem(
              title: 'Ibu Hamil/Menyusui',
              subtitle: '1 Orang x Rp. 750.000',
            ),
            BenefitBreakdownItem(
              title: 'Anak SD/Sederajat',
              subtitle: '1 Orang x Rp. 225.000',
            ),
            BenefitBreakdownItem(
              title: 'Anak SLTP/Sederajat',
              subtitle: '2 Orang x Rp. 225.000',
            ),
          ],
          historyTitle: 'Riwayat Pencairan',
          historyItems: const [
            BenefitTimelineItem(
              title: 'Tahap I Jan - Maret 2026',
              description: 'Dicairkan 25 Feb 2026 via BRI',
              amount: 'Sebesar Rp. 750.000',
            ),
            BenefitTimelineItem(
              title: 'Tahap II Apr - Jun 2026',
              description: 'Dicairkan 25 Apr 2026 via BRI',
              amount: 'Sebesar Rp. 750.000',
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: AppDrawer(
        isLoggedIn: widget.isLoggedIn,
        onBerandaTap: () {
          _popAndCall(context, widget.onBerandaTap);
        },
        onAkunSayaTap: () {
          _popAndCall(context, widget.onAkunSayaTap);
        },
        onInformasiLayananTap: () {},
        onKeluarAkunTap: () {
          _popAndCall(context, widget.onKeluarAkunTap);
        },
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
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      14,
                      16,
                      14,
                    ),
                    items: [
                      BreadcrumbItem(
                        label: 'Beranda',
                        onTap: () {
                          _popAndCall(context, widget.onBerandaTap);
                        },
                      ),
                      BreadcrumbItem(
                        label: 'Benefit',
                        onTap: () {
                          Navigator.of(context).maybePop();
                        },
                      ),
                      BreadcrumbItem(
                        label: _data.title,
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BenefitDetailOverviewCard(
                          title: _data.title,
                          statusDate: _data.statusDate,
                          statusLabel: _data.statusLabel,
                          items: _data.summaryItems,
                        ),

                        const SizedBox(height: 24),

                        BenefitTextSection(
                          title: 'Deskripsi Benefit',
                          description: _data.description,
                        ),

                        if (_data.breakdownItems.isNotEmpty) ...[
                          const Divider(
                            height: 40,
                            thickness: 0.5,
                            color: AppColors.strokePrimary,
                          ),
                          BenefitBreakdownSection(
                            description: _data.breakdownDescription,
                            items: _data.breakdownItems,
                          ),
                        ],

                        const Divider(
                          height: 40,
                          thickness: 0.5,
                          color: AppColors.strokePrimary,
                        ),

                        BenefitTimelineSection(
                          title: _data.historyTitle,
                          items: _data.historyItems,
                        ),

                        const Divider(
                          height: 40,
                          thickness: 0.5,
                          color: AppColors.strokePrimary,
                        ),

                        const HelpfulReviewSection(),

                        const SizedBox(height: 52),
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
}

class _BenefitDetailData {
  final String title;
  final String statusDate;
  final String statusLabel;
  final List<BenefitSummaryInfo> summaryItems;
  final String description;
  final String breakdownDescription;
  final List<BenefitBreakdownItem> breakdownItems;
  final String historyTitle;
  final List<BenefitTimelineItem> historyItems;

  const _BenefitDetailData({
    required this.title,
    required this.statusDate,
    required this.statusLabel,
    required this.summaryItems,
    required this.description,
    this.breakdownDescription = '',
    required this.breakdownItems,
    required this.historyTitle,
    required this.historyItems,
  });
}