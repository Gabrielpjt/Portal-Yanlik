import '../../domain/entities/service_detail_entity.dart';
import '../../domain/repositories/service_detail_repository.dart';
import '../datasources/service_detail_remote_datasource.dart';

class ServiceDetailRepositoryImpl implements ServiceDetailRepository {
  final ServiceDetailRemoteDatasource remoteDatasource;

  ServiceDetailRepositoryImpl(this.remoteDatasource);

  @override
  Future<ServiceDetailEntity> getDetail(int id) {
    return remoteDatasource.getDetail(id);
  }
}