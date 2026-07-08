import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import '../../data/datasources/search_remote_datasource.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/entities/search_result_entity.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_header.dart';
import '../widgets/search_result_card.dart';
import '../../../../shared/widgets/app_footer.dart';

class SearchPage extends StatefulWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final bool isLoggedIn;

  const SearchPage({
    super.key,
    this.onMenuTap,
    this.onLoginTap,
    this.isLoggedIn = false,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _totalPages = 5;
  late final SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchController.text = 'Akta kelahiran';
    
    // Initialize Bloc
    final apiClient = ApiClient();
    final remoteDatasource = SearchRemoteDatasource(apiClient);
    final repository = SearchRepositoryImpl(remoteDatasource);
    _searchBloc = SearchBloc(repository);
    
    // Perform initial search
    _performSearch();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      _searchBloc.add(SearchAllEvent(query));
    }
  }

  void _onFilterChanged(SearchFilter filter) {
    _searchBloc.add(ChangeSearchFilterEvent(filter));
  }

  List<FilterChipItem> _buildChips(SearchState state) {
    if (state is SearchSuccess) {
      return [
        FilterChipItem(
          key: 'all',
          label: 'Semua',
          count: state.results.length,
        ),
        FilterChipItem(
          key: 'layanan',
          label: 'Layanan',
          count: state.layananResults.length,
        ),
        FilterChipItem(
          key: 'informasi',
          label: 'Informasi',
          count: state.informasiLayananResults.length,
        ),
      ];
    }
    return [
      const FilterChipItem(key: 'all', label: 'Semua', count: 0),
      const FilterChipItem(key: 'layanan', label: 'Layanan', count: 0),
      const FilterChipItem(key: 'informasi', label: 'Informasi', count: 0),
    ];
  }

  String _filterToKey(SearchFilter filter) {
    switch (filter) {
      case SearchFilter.layanan:
        return 'layanan';
      case SearchFilter.informasiLayanan:
        return 'informasi';
      case SearchFilter.all:
      default:
        return 'all';
    }
  }

  SearchFilter _keyToFilter(String key) {
    switch (key) {
      case 'layanan':
        return SearchFilter.layanan;
      case 'informasi':
        return SearchFilter.informasiLayanan;
      default:
        return SearchFilter.all;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            AppHeader(
              onMenuTap: widget.onMenuTap,
              onLoginTap: widget.onLoginTap,
              isLoggedIn: widget.isLoggedIn,
            ),
            const SearchHeader(),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question Title
                              const Text(
                                'Apa yang ingin Anda cari?',
                                style: TextStyle(
                                  color: AppColors.brandPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Search Input
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                        hintText: 'Cari layanan, informasi, FAQ...',
                                        hintStyle: const TextStyle(
                                          color: AppColors.contentSecondary,
                                          fontSize: 14,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
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
                                            width: 2,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: AppColors.contentSecondary,
                                          ),
                                          onPressed: () {
                                            _searchController.clear();
                                            _searchBloc.add(const ClearSearchEvent());
                                          },
                                        ),
                                      ),
                                      onSubmitted: (_) => _performSearch(),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.brandPrimary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      onPressed: _performSearch,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Result Status
                              if (state is SearchSuccess) ...[
                                Text(
                                  'Menampilkan hasil pencarian untuk',
                                  style: const TextStyle(
                                    color: AppColors.contentSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.query,
                                  style: const TextStyle(
                                    color: AppColors.brandPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              if (state is SearchEmpty) ...[
                                Text(
                                  'Tidak ditemukan hasil untuk',
                                  style: const TextStyle(
                                    color: AppColors.contentSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.query,
                                  style: const TextStyle(
                                    color: AppColors.brandPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 20),
                              // Filter and Sort
                              if (state is SearchSuccess)
                                FilterSortRow(
                                  sortLabel: 'Terbaru',
                                  onSortTap: () {
                                    // TODO: Implement sort
                                  },
                                ),
                              const SizedBox(height: 20),
                              // Filter Chips
                              if (state is SearchSuccess)
                                FilterChipsRow(
                                  chips: _buildChips(state),
                                  selectedKey: _filterToKey(state.currentFilter),
                                  onSelected: (key) {
                                    _onFilterChanged(_keyToFilter(key));
                                  },
                                ),
                              const SizedBox(height: 24),
                              // Search Results
                              _buildSearchResults(state),
                              const SizedBox(height: 24),
                              // Pagination
                              if (state is SearchSuccess &&
                                  state.filteredResults.isNotEmpty)
                                AppPagination(
                                  currentPage: _currentPage,
                                  totalPages: _totalPages,
                                  onPageChanged: (page) {
                                    setState(() {
                                      _currentPage = page;
                                    });
                                  },
                                ),
                              const SizedBox(height: 32),
                            ],
                          ),
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

  Widget _buildSearchResults(SearchState state) {
    if (state is SearchLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(
            color: AppColors.brandPrimary,
          ),
        ),
      );
    }

    if (state is SearchError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.contentSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: const TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _performSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandPrimary,
                ),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is SearchEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const Icon(
                Icons.search_off,
                size: 64,
                color: AppColors.contentSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'Tidak ditemukan hasil untuk "${state.query}"',
                style: const TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Coba kata kunci lain',
                style: TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state is SearchSuccess) {
      final results = state.filteredResults;

      if (results.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const Icon(
                  Icons.filter_alt_off,
                  size: 64,
                  color: AppColors.contentSecondary,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tidak ada hasil dengan filter ini',
                  style: TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Coba filter lain',
                  style: TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        children: results.map((result) {
          return SearchResultCard(
            category: _getCategoryName(result),
            title: result.title,
            location: _getLocation(result),
            lastUpdated: 'Baru saja', // TODO: Format date from API
            description: result.description,
            onTap: () {
              _onResultTap(result);
            },
          );
        }).toList(),
      );
    }

    return const SizedBox.shrink();
  }

  String _getCategoryName(SearchResultEntity result) {
    // Use module field from unified API
    switch (result.module) {
      case 'layanan':
        return 'Layanan';
      case 'informasi_layanan':
        return 'Informasi Layanan';
      default:
        return 'Lainnya';
    }
  }

  String _getLocation(SearchResultEntity result) {
    // Use cakupan field from API, or default to 'Nasional'
    if (result.cakupan != null && result.cakupan!.isNotEmpty) {
      return result.cakupan!;
    }
    return 'Nasional';
  }

  void _onResultTap(SearchResultEntity result) {
    // TODO: Navigate to detail page based on module
    // Use result.link if available for navigation
    if (result.link != null && result.link!.isNotEmpty) {
      // Open web link or navigate to detail page
      debugPrint('Open link: ${result.link}');
    }
  }
}
