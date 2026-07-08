import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

/// Concrete implementation of [UserRepository].
///
/// Delegates to [UserRemoteDatasource] and maps exceptions to [Failure].
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _remoteDatasource;

  UserRepositoryImpl(this._remoteDatasource);

  @override
  Future<(List<UserEntity>?, Failure?)> getUsers() async {
    try {
      final users = await _remoteDatasource.getUsers();
      return (users.cast<UserEntity>(), null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure('Unexpected error: $e'));
    }
  }
}
