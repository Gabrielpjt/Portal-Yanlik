import '../../../../core/network/api_client.dart';
import '../models/layanan_model.dart';

class LayananRemoteDatasource {
  final ApiClient _apiClient;

  LayananRemoteDatasource(this._apiClient);

  Future<List<LayananModel>> getLayanan() async {
    final response = await _apiClient.get('/publik/layanan');
    
    final Map<String, dynamic> body = response.data as Map<String, dynamic>;
    
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
        .map((json) => LayananModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
