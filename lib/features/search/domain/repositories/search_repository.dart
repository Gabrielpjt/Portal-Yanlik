import '../entities/search_result_entity.dart';

abstract class SearchRepository {
  /// Search all content (layanan + informasi_layanan)
  /// Uses unified /search endpoint
  Future<List<SearchResultEntity>> searchAll(
    String query, {
    int? page,
    int? limit,
  });

  /// Search layanan only
  /// Uses /search?module=layanan
  Future<List<SearchResultEntity>> searchLayanan(
    String query, {
    int? page,
    int? limit,
  });

  /// Search informasi layanan only
  /// Uses /search?module=informasi_layanan
  Future<List<SearchResultEntity>> searchInformasiLayanan(
    String query, {
    int? page,
    int? limit,
  });
}
