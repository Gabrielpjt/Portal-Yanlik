import '../../domain/entities/user_entity.dart';

/// Data model for User with JSON serialization.
///
/// Extends [UserEntity] and adds `fromJson` / `toJson`.
///
/// Example JSON (JSONPlaceholder):
/// ```json
/// {
///   "id": 1,
///   "name": "Leanne Graham",
///   "username": "Bret",
///   "email": "Sincere@april.biz",
///   "phone": "1-770-736-8031 x56442",
///   "website": "hildegard.org"
/// }
/// ```
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.phone,
    required super.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      website: json['website'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
    };
  }
}
