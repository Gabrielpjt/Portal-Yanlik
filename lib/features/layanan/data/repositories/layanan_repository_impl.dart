import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../domain/entities/layanan_entity.dart';
import '../../domain/repositories/layanan_repository.dart';
import '../datasources/layanan_remote_datasource.dart';

class LayananRepositoryImpl implements LayananRepository {
  final LayananRemoteDatasource _remoteDatasource;

  LayananRepositoryImpl(this._remoteDatasource);

  @override
  Future<(List<LayananEntity>?, Failure?)> getLayanan() async {
    try {
      final items = await _remoteDatasource.getLayanan();
      return (items.cast<LayananEntity>(), null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }
}
