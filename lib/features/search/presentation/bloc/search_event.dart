import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

/// Event to search all content (layanan + informasi_layanan)
class SearchAllEvent extends SearchEvent {
  final String query;
  final int? page;
  final int? limit;

  const SearchAllEvent(
    this.query, {
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [query, page, limit];
}

/// Event to search layanan only
class SearchLayananEvent extends SearchEvent {
  final String query;
  final int? page;
  final int? limit;

  const SearchLayananEvent(
    this.query, {
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [query, page, limit];
}

/// Event to search informasi layanan only
class SearchInformasiLayananEvent extends SearchEvent {
  final String query;
  final int? page;
  final int? limit;

  const SearchInformasiLayananEvent(
    this.query, {
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [query, page, limit];
}

/// Event to clear search results
class ClearSearchEvent extends SearchEvent {
  const ClearSearchEvent();
}

/// Event to change search filter
class ChangeSearchFilterEvent extends SearchEvent {
  final SearchFilter filter;

  const ChangeSearchFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

/// Search filter enum - simplified to match API
enum SearchFilter {
  all,          // No module filter
  layanan,      // module=layanan
  informasiLayanan, // module=informasi_layanan
}
