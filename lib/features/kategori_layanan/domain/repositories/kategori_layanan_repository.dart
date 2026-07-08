import '../../../../core/errors/failure.dart';
import '../entities/kategori_layanan_entity.dart';

abstract class KategoriLayananRepository {
  Future<(List<KategoriLayananEntity>?, Failure?)> getKategoriLayanan();
}
