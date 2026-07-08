import '../../domain/entities/service_detail_entity.dart';

abstract class ServiceDetailRepository {
  Future<ServiceDetailEntity> getDetail(int id);
}