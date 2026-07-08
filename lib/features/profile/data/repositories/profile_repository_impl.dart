import '../../domain/entities/auth_session_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl(this.remoteDatasource);

  @override
  Future<AuthSessionEntity> login({
    required String username,
    required String password,
  }) {
    return remoteDatasource.login(
      username: username,
      password: password,
    );
  }

  @override
  Future<UserProfileEntity> getProfile({
    required String token,
  }) {
    return remoteDatasource.getProfile(token: token);
  }

  @override
  Future<UserProfileEntity> updateProfile({
    required String token,
    required String email,
  }) {
    return remoteDatasource.updateProfile(
      token: token,
      email: email,
    );
  }

  @override
  Future<void> logout({
    String? token,
  }) {
    return remoteDatasource.logout(token: token);
  }
}