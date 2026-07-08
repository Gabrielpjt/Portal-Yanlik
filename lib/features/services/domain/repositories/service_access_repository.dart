import '../entities/service_access_item_entity.dart';
import '../entities/service_access_type.dart';

abstract class ServiceAccessRepository {
  Future<List<ServiceAccessItemEntity>> search({
    required ServiceAccessSearchType type,
    required String token,
    required int page,
    required int limit,
    String query = '',
    String category = '',
  });

  Future<ServiceAccessItemEntity> getDetail({
    required ServiceAccessSearchType type,
    required String token,
    required String id,
  });
}
