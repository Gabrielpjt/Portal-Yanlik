import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final int? id;
  final String username;
  final String email;
  final int? instansiId;
  final String? instansiName;
  final int? peranId;
  final String? peranLabel;

  const UserProfileEntity({
    this.id,
    required this.username,
    required this.email,
    this.instansiId,
    this.instansiName,
    this.peranId,
    this.peranLabel,
  });

  String get displayName {
    if (username.trim().isNotEmpty) {
      return username;
    }

    if (email.trim().isNotEmpty) {
      return email;
    }

    return 'Pengguna';
  }

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    instansiId,
    instansiName,
    peranId,
    peranLabel,
  ];
}