import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_response.dart';
import '../entities/post_entity.dart';

/// Abstract repository contract for Post operations.
///
/// Implemented by [PostRepositoryImpl] in the data layer.
abstract class PostRepository {
  /// Fetch a paginated list of posts.
  ///
  /// Returns a [PaginatedResponse] on success, or a [Failure] on error.
  Future<(PaginatedResponse<PostEntity>?, Failure?)> getPosts({
    required int page,
    int limit = 10,
  });

  /// Fetch a single post by its [id].
  ///
  /// Returns the [PostEntity] on success, or a [Failure] on error.
  Future<(PostEntity?, Failure?)> getPostById(int id);
}
