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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  String _selectedSort = 'Terbaru';
  int _currentPage = 1;
  final int _totalPages = 5;

  // Mock data artikel
  final List<Map<String, dynamic>> _allArticles = [
    {
      'key': 'kependudukan',
      'category': 'Kependudukan',
      'publishedDate': '13 Feb 2026',
      'title':
          'Pengurusan Akta Kelahiran Kini Bisa 100% Online, Tidak Perlu ke Kantor',
      'description':
          'Direktorat Jenderal Kependudukan dan Pencatatan Sipil (Dukcapil) Kementerian Dalam Negeri meluncur...',
      'imageUrl':
          'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&q=80',
      'likes': '20,8 K',
      'comments': '20,8 K',
    },
    {
      'key': 'kependudukan',
      'category': 'Kependudukan',
      'publishedDate': '10 Feb 2026',
      'title': 'Cara Mudah Mengurus KTP Elektronik Secara Online di Rumah',
      'description':
          'Kini masyarakat dapat mengurus KTP elektronik tanpa harus mengantri panjang di kantor Dukcapil. Dengan sistem online...',
      'imageUrl':
          'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=800&q=80',
      'likes': '15,2 K',
      'comments': '8,4 K',
    },
    {
      'key': 'bantuan_sosial',
      'category': 'Bantuan Sosial',
      'publishedDate': '05 Feb 2026',
      'title':
          'Program Bansos PKH 2026: Siapa Saja yang Berhak Mendapat Bantuan?',
      'description':
          'Pemerintah melalui Kementerian Sosial kembali menyalurkan Program Keluarga Harapan (PKH) tahun 2026. Berikut kriteria penerima...',
      'imageUrl':
          'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=800&q=80',
      'likes': '32,1 K',
      'comments': '12,7 K',
    },
  ];

  List<Map<String, dynamic>> get _filteredArticles {
    if (_selectedFilter == 'all') return _allArticles;
    return _allArticles.where((a) => a['key'] == _selectedFilter).toList();
  }

  List<FilterChipItem> get _chips {
    final kependudukanCount = _allArticles
        .where((a) => a['key'] == 'kependudukan')
        .length;
    final bantuanCount = _allArticles
        .where((a) => a['key'] == 'bantuan_sosial')
        .length;
    return [
      FilterChipItem(key: 'all', label: 'Semua', count: _allArticles.length),
      FilterChipItem(
        key: 'kependudukan',
        label: 'Kependudukan',
        count: kependudukanCount,
      ),
      FilterChipItem(
        key: 'bantuan_sosial',
        label: 'Bantuan Sosial',
        count: bantuanCount,
      ),
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
        onInformasiLayananTap: () {
          // Sudah di halaman ini — tutup drawer saja
        },
        onAkunSayaTap: () => _popAndCall(context, widget.onAkunSayaTap),
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
                  // Breadcrumb
                  BreadcrumbWidget(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    items: [
                      BreadcrumbItem(
                        label: 'Beranda',
                        onTap: () => _popAndCall(context, widget.onBerandaTap),
                      ),
                      const BreadcrumbItem(label: 'Informasi Layanan'),
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
                            'Informasi Layanan',
                            style: TextStyle(
                              color: AppColors.brandPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_allArticles.length} Informasi',
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

                  // Filter & Sort Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

                  const SizedBox(height: 12),

                  // Filter Chips Row
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

                  // Article Cards
                  ..._filteredArticles.map((article) {
                    return _ArticleCard(
                      category: article['category'],
                      publishedDate: article['publishedDate'],
                      title: article['title'],
                      description: article['description'],
                      imageUrl: article['imageUrl'],
                      likes: article['likes'],
                      comments: article['comments'],
                      onTap: () {},
                    );
                  }),

                  const SizedBox(height: 8),

                  // Pagination
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppPagination(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
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

// ── Article Card ──────────────────────────────────────────────────────────────

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
            // Thumbnail Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: AppColors.backgroundSecondary,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.brandPrimary,
                        ),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.backgroundSecondary,
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColors.contentSecondary,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + Date
                  Row(
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          color: AppColors.brandPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Description
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

                  // Likes + Comments
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
