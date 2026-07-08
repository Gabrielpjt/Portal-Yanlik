import '../../../../core/network/api_client.dart';
import '../models/informasi_layanan_model.dart';

/// Remote data source for Informasi Layanan API calls.
///
/// Talks directly to the Portal Layanan Publik REST API via [ApiClient].
///
/// Usage:
/// ```dart
/// final datasource = InformasiLayananRemoteDatasource(apiClient);
/// final items = await datasource.getInformasiLayanan(page: 1, limit: 5);
/// ```
class InformasiLayananRemoteDatasource {
  final ApiClient _apiClient;

  InformasiLayananRemoteDatasource(this._apiClient);

  /// Fetch a paginated list of informasi layanan.
  ///
  /// The Portal API uses `page` and `limit` query params.
  /// The response wraps items in a `ProxyResponse` envelope:
  /// ```json
  /// {
  ///   "success": true,
  ///   "code": 200,
  ///   "message": "Berhasil",
  ///   "data": [ ... ]
  /// }
  /// ```
  Future<List<InformasiLayananModel>> getInformasiLayanan({
    int page = 1,
    int limit = 5,
    String? query,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'page': page,
      'limit': limit,
      'pagination': 'true',
    };

    if (query != null && query.isNotEmpty) {
      queryParameters['q'] = query;
    }

    final response = await _apiClient.get(
      '/publik/informasi-layanan',
      queryParameters: queryParameters,
    );

    final Map<String, dynamic> body = response.data as Map<String, dynamic>;
    
    // The API might return the list directly in `body['data']`
    // or wrap it in a pagination object: `body['data']['data']`.
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

    return data
        .map((json) =>
            InformasiLayananModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Fetch a single informasi layanan by [id].
  Future<InformasiLayananModel> getInformasiLayananById(int id) async {
    final response = await _apiClient.get('/publik/informasi-layanan/$id');
    final Map<String, dynamic> body = response.data as Map<String, dynamic>;
    return InformasiLayananModel.fromJson(
        body['data'] as Map<String, dynamic>);
  }
}
