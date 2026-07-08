import 'package:equatable/equatable.dart';

/// Domain entity representing a user.
///
/// This is the pure domain object with no serialization logic.
/// See [UserModel] for the JSON-aware data layer counterpart.
class UserEntity extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  @override
  List<Object?> get props => [id, name, username, email, phone, website];
}
