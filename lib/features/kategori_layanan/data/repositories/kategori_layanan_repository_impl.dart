import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../domain/entities/kategori_layanan_entity.dart';
import '../../domain/repositories/kategori_layanan_repository.dart';
import '../datasources/kategori_layanan_remote_datasource.dart';

class KategoriLayananRepositoryImpl implements KategoriLayananRepository {
  final KategoriLayananRemoteDatasource _remoteDatasource;

  KategoriLayananRepositoryImpl(this._remoteDatasource);

  @override
  Future<(List<KategoriLayananEntity>?, Failure?)> getKategoriLayanan() async {
    try {
      final items = await _remoteDatasource.getKategoriLayanan();
      return (items.cast<KategoriLayananEntity>(), null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }
}
