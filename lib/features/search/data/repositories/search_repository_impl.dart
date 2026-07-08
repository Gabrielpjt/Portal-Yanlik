import '../../domain/entities/search_result_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource _remoteDatasource;

  SearchRepositoryImpl(this._remoteDatasource);

  @override
  Future<List<SearchResultEntity>> searchAll(
    String query, {
    int? page,
    int? limit,
  }) async {
    try {
      return await _remoteDatasource.searchAll(
        query,
        page: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchResultEntity>> searchLayanan(
    String query, {
    int? page,
    int? limit,
  }) async {
    try {
      return await _remoteDatasource.searchLayanan(
        query,
        page: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchResultEntity>> searchInformasiLayanan(
    String query, {
    int? page,
    int? limit,
  }) async {
    try {
      return await _remoteDatasource.searchInformasiLayanan(
        query,
        page: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }
}
