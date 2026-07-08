import 'package:equatable/equatable.dart';

abstract class UserSessionEvent extends Equatable {
  const UserSessionEvent();

  @override
  List<Object?> get props => [];
}

class SetUserSession extends UserSessionEvent {
  final String token;
  final String name;
  final String email;
  final String? avatarUrl;

  const SetUserSession({
    this.token = '',
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [
    token,
    name,
    email,
    avatarUrl,
  ];
}

class ClearUserSession extends UserSessionEvent {
  const ClearUserSession();
}