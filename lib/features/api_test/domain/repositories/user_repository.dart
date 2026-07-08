import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';

/// Abstract repository contract for User operations.
///
/// Implemented by [UserRepositoryImpl] in the data layer.
abstract class UserRepository {
  /// Fetch all users (no pagination).
  ///
  /// Returns a list of [UserEntity] on success, or a [Failure] on error.
  Future<(List<UserEntity>?, Failure?)> getUsers();
}
