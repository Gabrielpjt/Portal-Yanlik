import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/navigation/sidebar/app_drawer.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';

class BenefitPage extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback? onLoginTap;
  final VoidCallback? onBerandaTap;
  final VoidCallback? onAkunSayaTap;
  final VoidCallback? onKeluarAkunTap;

  const BenefitPage({
    super.key,
    this.isLoggedIn = true,
    this.onLoginTap,
    this.onBerandaTap,
    this.onAkunSayaTap,
    this.onKeluarAkunTap,
  });

  @override
  State<BenefitPage> createState() => _BenefitPageState();
}

class _BenefitPageState extends State<BenefitPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'all';
  String _selectedSort = 'Terbaru';
  int _currentPage = 1;
  final int _totalPages = 2;

  static const _allBenefits = [
    {
      'key': 'bantuan_sosial',
      'name': 'Program Keluarga Harapan',
      'amount': '75.000',
      'period': 'Per triwulan',
      'status': 'Aktif',
      'cair': 'Cair Feb 2026',
    },
    {
      'key': 'bantuan_sosial',
      'name': 'Bantuan Pangan Non Tunai',
      'amount': '118.000',
      'period': 'Saldo tersedia',
      'status': 'Aktif',
      'cair': null,
    },
    {
      'key': 'pendidikan',
      'name': 'Kartu Indonesia Pintar',
      'amount': '900.000',
      'period': 'Per semester',
      'status': 'Aktif',
      'cair': 'Cair Okt 2026',
    },
    {
      'key': 'pendidikan',
      'name': 'Kartu Prakerja',
      'amount': '600.000',
      'period': 'Per semester',
      'status': 'Aktif',
      'cair': 'Cair Okt 2026',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedFilter == 'all') return _allBenefits;
    return _allBenefits.where((b) => b['key'] == _selectedFilter).toList();
  }

  List<FilterChipItem> get _chips {
    final bantuanCount =
        _allBenefits.where((b) => b['key'] == 'bantuan_sosial').length;
    final pendidikanCount =
        _allBenefits.where((b) => b['key'] == 'pendidikan').length;
    return [
      FilterChipItem(
          key: 'all', label: 'Semua', count: _allBenefits.length),
      FilterChipItem(
          key: 'bantuan_sosial', label: 'Bantuan Sosial', count: bantuanCount),
      FilterChipItem(
          key: 'pendidikan', label: 'Pendidikan', count: pendidikanCount),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  void _popAndCall(BuildContext context, VoidCallback? callback) {
    final nav = Navigator.of(context);
    if (nav.canPop()) nav.pop();
    if (callback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => callback());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: AppDrawer(
        isLoggedIn: widget.isLoggedIn,
        onBerandaTap: () => _popAndCall(context, widget.onBerandaTap),
        onAkunSayaTap: () => _popAndCall(context, widget.onAkunSayaTap),
        onInformasiLayananTap: () {},
        onKeluarAkunTap: () => _popAndCall(context, widget.onKeluarAkunTap),
        onApiTestTap: () =>
            Navigator.of(context).pushNamed(AppRouter.apiTest),
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
                  // Breadcrumb
                  BreadcrumbWidget(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    items: [
                      BreadcrumbItem(
                        label: 'Beranda',
                        onTap: () => _popAndCall(context, widget.onBerandaTap),
                      ),
                      const BreadcrumbItem(label: 'Benefit'),
                    ],
                  ),

                  // Title Card
                  Padding(
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
                            'Benefit',
                            style: TextStyle(
                              color: AppColors.brandPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_allBenefits.length} Benefit',
                            style: const TextStyle(
                              color: AppColors.contentSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari benefit',
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
                              color: AppColors.strokePrimary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.strokePrimary),
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

                  // Filter & Sort
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

                  const SizedBox(height: 12),

                  // Filter Chips
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FilterChipsRow(
                      chips: _chips,
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

                  // Benefit Cards List
                  ..._filtered.map((b) => _BenefitListCard(
                        name: b['name'] as String,
                        amount: b['amount'] as String,
                        period: b['period'] as String,
                        status: b['status'] as String,
                        cairDate: b['cair'] as String?,
                      )),

                  const SizedBox(height: 16),

                  // Pagination
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppPagination(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                      onPageChanged: (p) => setState(() => _currentPage = p),
                    ),
                  ),

                  const SizedBox(height: 32),
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

// ── Benefit List Card (full-width) ────────────────────────────────────────────

class _BenefitListCard extends StatelessWidget {
  final String name;
  final String amount;
  final String period;
  final String status;
  final String? cairDate;

  const _BenefitListCard({
    required this.name,
    required this.amount,
    required this.period,
    required this.status,
    this.cairDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Arrow
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.brandPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_outward,
                size: 16,
                color: AppColors.contentSecondary,
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Amount
          RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.brandPrimary),
              children: [
                const TextSpan(
                  text: 'Rp. ',
                  style: TextStyle(fontSize: 14),
                ),
                TextSpan(
                  text: amount,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Period + Status Badges
          Row(
            children: [
              Text(
                period,
                style: const TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              _Badge(label: status, isGreen: true),
              if (cairDate != null) ...[
                const SizedBox(width: 6),
                _Badge(label: cairDate!, isGreen: false),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final bool isGreen;

  const _Badge({required this.label, required this.isGreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color:
            isGreen ? const Color(0xFFDCFCE7) : const Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isGreen ? const Color(0xFF15803D) : const Color(0xFF1D4ED8),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
