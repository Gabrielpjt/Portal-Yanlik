import 'package:equatable/equatable.dart';
import '../../domain/entities/search_result_entity.dart';
import 'search_event.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SearchInitial extends SearchState {
  const SearchInitial();
}

/// Loading state
class SearchLoading extends SearchState {
  const SearchLoading();
}

/// Success state with results
class SearchSuccess extends SearchState {
  final List<SearchResultEntity> results;
  final SearchFilter currentFilter;
  final String query;

  const SearchSuccess({
    required this.results,
    required this.currentFilter,
    required this.query,
  });

  @override
  List<Object?> get props => [results, currentFilter, query];

  /// Helper to get filtered results by module
  List<SearchResultEntity> get layananResults =>
      results.where((r) => r.module == 'layanan').toList();

  List<SearchResultEntity> get informasiLayananResults =>
      results.where((r) => r.module == 'informasi_layanan').toList();

  /// Get results based on current filter
  List<SearchResultEntity> get filteredResults {
    switch (currentFilter) {
      case SearchFilter.layanan:
        return layananResults;
      case SearchFilter.informasiLayanan:
        return informasiLayananResults;
      case SearchFilter.all:
      default:
        return results;
    }
  }

  /// Check if results are empty
  bool get isEmpty => results.isEmpty;

  /// Check if filtered results are empty
  bool get isFilteredEmpty => filteredResults.isEmpty;

  /// Copy with method
  SearchSuccess copyWith({
    List<SearchResultEntity>? results,
    SearchFilter? currentFilter,
    String? query,
  }) {
    return SearchSuccess(
      results: results ?? this.results,
      currentFilter: currentFilter ?? this.currentFilter,
      query: query ?? this.query,
    );
  }
}

/// Error state
class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Empty state (no results found)
class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty(this.query);

  @override
  List<Object?> get props => [query];
}
