import '../../../../core/network/api_client.dart';
import '../models/post_model.dart';

/// Remote data source for Post-related API calls.
///
/// Talks directly to the REST API via [ApiClient].
///
/// Usage:
/// ```dart
/// final datasource = PostRemoteDatasource(apiClient);
/// final posts = await datasource.getPosts(page: 1, limit: 10);
/// ```
class PostRemoteDatasource {
  final ApiClient _apiClient;

  PostRemoteDatasource(this._apiClient);

  /// Fetch a paginated list of posts.
  ///
  /// JSONPlaceholder uses `_page` and `_limit` query params.
  /// The total count is returned in the `x-total-count` response header.
  Future<(List<PostModel>, int)> getPosts({
    required int page,
    int limit = 10,
  }) async {
    final response = await _apiClient.get(
      '/posts',
      queryParameters: {
        '_page': page,
        '_limit': limit,
      },
    );

    final totalCount = int.tryParse(
          response.headers.value('x-total-count') ?? '',
        ) ??
        0;

    final List<dynamic> data = response.data as List<dynamic>;
    final posts = data
        .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return (posts, totalCount);
  }

  /// Fetch a single post by [id].
  Future<PostModel> getPostById(int id) async {
    final response = await _apiClient.get('/posts/$id');
    return PostModel.fromJson(response.data as Map<String, dynamic>);
  }
}
