import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_response.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_datasource.dart';

/// Concrete implementation of [PostRepository].
///
/// Delegates to [PostRemoteDatasource] and maps exceptions to [Failure].
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDatasource _remoteDatasource;

  PostRepositoryImpl(this._remoteDatasource);

  @override
  Future<(PaginatedResponse<PostEntity>?, Failure?)> getPosts({
    required int page,
    int limit = 10,
  }) async {
    try {
      final (posts, totalCount) = await _remoteDatasource.getPosts(
        page: page,
        limit: limit,
      );

      final totalPages = (totalCount / limit).ceil();

      final paginated = PaginatedResponse<PostEntity>(
        items: posts,
        currentPage: page,
        totalPages: totalPages,
        totalItems: totalCount,
      );

      return (paginated, null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<(PostEntity?, Failure?)> getPostById(int id) async {
    try {
      final post = await _remoteDatasource.getPostById(id);
      return (post as PostEntity, null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure('Unexpected error: $e'));
    }
  }
}
