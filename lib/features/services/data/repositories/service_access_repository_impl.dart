import '../../../../core/errors/failure.dart';
import '../../domain/entities/service_access_item_entity.dart';
import '../../domain/entities/service_access_type.dart';
import '../../domain/repositories/service_access_repository.dart';
import '../datasources/service_access_remote_datasource.dart';

class ServiceAccessRepositoryImpl implements ServiceAccessRepository {
  final ServiceAccessRemoteDatasource remoteDatasource;

  ServiceAccessRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<ServiceAccessItemEntity>> search({
    required ServiceAccessSearchType type,
    required String token,
    required int page,
    required int limit,
    String query = '',
    String category = '',
    bool fetchAll = false,
  }) {
    switch (type) {
      case ServiceAccessSearchType.healthFacility:
        return remoteDatasource.searchFasyankes(
          token: token,
          page: page,
          limit: limit,
          query: query,
          jenisSarana: category,
          fetchAll: fetchAll,
        );
      case ServiceAccessSearchType.doctor:
        throw const ServerFailure('API cari dokter belum tersedia.');
      case ServiceAccessSearchType.bpomProduct:
        throw const ServerFailure('API cek BPOM belum tersedia.');
    }
  }

  @override
  Future<ServiceAccessItemEntity> getDetail({
    required ServiceAccessSearchType type,
    required String token,
    required String id,
  }) {
    switch (type) {
      case ServiceAccessSearchType.healthFacility:
        return remoteDatasource.getFasyankesDetail(
          token: token,
          id: id,
        );
      case ServiceAccessSearchType.doctor:
        throw const ServerFailure('API detail dokter belum tersedia.');
      case ServiceAccessSearchType.bpomProduct:
        throw const ServerFailure('API detail BPOM belum tersedia.');
    }
  }
}
