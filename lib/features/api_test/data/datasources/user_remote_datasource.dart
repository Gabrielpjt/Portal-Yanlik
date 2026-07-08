import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

/// Remote data source for User-related API calls.
///
/// Talks directly to the REST API via [ApiClient].
///
/// Usage:
/// ```dart
/// final datasource = UserRemoteDatasource(apiClient);
/// final users = await datasource.getUsers();
/// ```
class UserRemoteDatasource {
  final ApiClient _apiClient;

  UserRemoteDatasource(this._apiClient);

  /// Fetch all users (no pagination).
  Future<List<UserModel>> getUsers() async {
    final response = await _apiClient.get('/users');

    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
