import '../entities/auth_session_entity.dart';
import '../entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<AuthSessionEntity> login({
    required String username,
    required String password,
  });

  Future<UserProfileEntity> getProfile({
    required String token,
  });

  Future<UserProfileEntity> updateProfile({
    required String token,
    required String email,
  });

  Future<void> logout({
    String? token,
  });
}