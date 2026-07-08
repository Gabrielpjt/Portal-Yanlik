import '../../../../core/errors/failure.dart';
import '../entities/layanan_entity.dart';

abstract class LayananRepository {
  Future<(List<LayananEntity>?, Failure?)> getLayanan();
}
