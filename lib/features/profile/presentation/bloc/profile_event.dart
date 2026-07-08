import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends ProfileEvent {
  final String username;
  final String password;

  const LoginSubmitted({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class LoadProfileRequested extends ProfileEvent {
  final String? token;

  const LoadProfileRequested({
    this.token,
  });

  @override
  List<Object?> get props => [token];
}

class UpdateProfileEmailRequested extends ProfileEvent {
  final String email;

  const UpdateProfileEmailRequested({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class LogoutRequested extends ProfileEvent {
  const LogoutRequested();
}