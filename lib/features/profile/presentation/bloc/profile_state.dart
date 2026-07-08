import 'package:equatable/equatable.dart';

import '../../domain/entities/user_profile_entity.dart';

enum ProfileStatus {
  initial,
  loading,
  loginSuccess,
  profileSuccess,
  updateSuccess,
  otpRequired,
  logoutSuccess,
  failure,
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserProfileEntity? profile;
  final String token;
  final String message;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.token = '',
    this.message = '',
  });

  bool get isLoading => status == ProfileStatus.loading;

  ProfileState copyWith({
    ProfileStatus? status,
    UserProfileEntity? profile,
    String? token,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      token: token ?? this.token,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profile,
    token,
    message,
  ];
}