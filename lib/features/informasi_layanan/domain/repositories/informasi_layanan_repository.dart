import '../../../../core/errors/failure.dart';
import '../entities/informasi_layanan_entity.dart';

/// Abstract repository contract for Informasi Layanan operations.
///
/// Implemented by [InformasiLayananRepositoryImpl] in the data layer.
abstract class InformasiLayananRepository {
  /// Fetch a list of informasi layanan.
  ///
  /// Returns a list of [InformasiLayananEntity] on success, or a [Failure] on error.
  Future<(List<InformasiLayananEntity>?, Failure?)> getInformasiLayanan({
    int page = 1,
    int limit = 5,
    String? query,
  });

  /// Fetch a single informasi layanan by its [id].
  ///
  /// Returns the [InformasiLayananEntity] on success, or a [Failure] on error.
  Future<(InformasiLayananEntity?, Failure?)> getInformasiLayananById(int id);
}
