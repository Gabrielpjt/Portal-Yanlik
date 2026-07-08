import '../../../../core/network/api_client.dart';
import '../../../../core/utils/logger.dart';
import '../models/search_result_model.dart';

class SearchRemoteDatasource {
  final ApiClient _apiClient;

  SearchRemoteDatasource(this._apiClient);

  /// Unified search using /search endpoint
  /// 
  /// Parameters:
  /// - query: Search keyword (min 2 characters)
  /// - module: Filter by module ('layanan', 'informasi_layanan', or null for all)
  /// - page: Page number
  /// - limit: Results per page
  Future<List<SearchResultModel>> search(
    String query, {
    String? module,
    int? page,
    int? limit,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'q': query,
        if (module != null) 'module': module,
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        'pagination': 'true',
      };

      Logger.log(
        'Searching with params: $queryParams',
        tag: 'SearchDatasource',
      );

      final response = await _apiClient.get(
        '/search',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> body = response.data as Map<String, dynamic>;

      // Handle different response formats
      List<dynamic> data = [];
      if (body['data'] is List) {
        data = body['data'] as List<dynamic>;
      } else if (body['data'] is Map) {
        final mapData = body['data'] as Map<String, dynamic>;
        if (mapData['items'] is List) {
          data = mapData['items'] as List<dynamic>;
        } else if (mapData['data'] is List) {
          data = mapData['data'] as List<dynamic>;
        }
      }

      Logger.log(
        'Search returned ${data.length} results',
        tag: 'SearchDatasource',
      );

      return data
          .map((json) =>
              SearchResultModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.log('Error searching: $e', tag: 'SearchDatasource');
      rethrow;
    }
  }

  /// Search all content (no module filter)
  Future<List<SearchResultModel>> searchAll(
    String query, {
    int? page,
    int? limit,
  }) async {
    return search(query, page: page, limit: limit);
  }

  /// Search layanan only
  Future<List<SearchResultModel>> searchLayanan(
    String query, {
    int? page,
    int? limit,
  }) async {
    return search(query, module: 'layanan', page: page, limit: limit);
  }

  /// Search informasi layanan only
  Future<List<SearchResultModel>> searchInformasiLayanan(
    String query, {
    int? page,
    int? limit,
  }) async {
    return search(
      query,
      module: 'informasi_layanan',
      page: page,
      limit: limit,
    );
  }
}
