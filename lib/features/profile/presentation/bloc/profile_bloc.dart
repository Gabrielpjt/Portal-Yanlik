import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/user_session/user_session_bloc.dart';
import '../../../../core/bloc/user_session/user_session_event.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;
  final UserSessionBloc userSessionBloc;

  ProfileBloc({
    required this.repository,
    required this.userSessionBloc,
  }) : super(const ProfileState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoadProfileRequested>(_onLoadProfileRequested);
    on<UpdateProfileEmailRequested>(_onUpdateProfileEmailRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(
      status: ProfileStatus.loading,
      message: '',
    ));

    try {
      final session = await repository.login(
        username: event.username,
        password: event.password,
      );

      if (session.isOtpRequired || session.token.isEmpty) {
        emit(state.copyWith(
          status: ProfileStatus.otpRequired,
          token: session.token,
          message:
          'Akun ini membutuhkan verifikasi OTP.',
        ));
        return;
      }

      final profile = await repository.getProfile(
        token: session.token,
      );

      userSessionBloc.add(
        SetUserSession(
          token: session.token,
          name: profile.displayName,
          email: profile.email,
        ),
      );

      emit(state.copyWith(
        status: ProfileStatus.loginSuccess,
        token: session.token,
        profile: profile,
        message: 'Login berhasil.',
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: _errorMessage(error),
      ));
    }
  }

  Future<void> _onLoadProfileRequested(
      LoadProfileRequested event,
      Emitter<ProfileState> emit,
      ) async {
    final token = event.token ?? userSessionBloc.state.token;

    if (token.isEmpty) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: 'Token login tidak ditemukan. Silakan login ulang.',
      ));
      return;
    }

    emit(state.copyWith(
      status: ProfileStatus.loading,
      token: token,
      message: '',
    ));

    try {
      final profile = await repository.getProfile(
        token: token,
      );

      userSessionBloc.add(
        SetUserSession(
          token: token,
          name: profile.displayName,
          email: profile.email,
        ),
      );

      emit(state.copyWith(
        status: ProfileStatus.profileSuccess,
        token: token,
        profile: profile,
        message: 'Profil berhasil dimuat.',
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: _errorMessage(error),
      ));
    }
  }

  Future<void> _onUpdateProfileEmailRequested(
      UpdateProfileEmailRequested event,
      Emitter<ProfileState> emit,
      ) async {
    final token = state.token.isNotEmpty
        ? state.token
        : userSessionBloc.state.token;

    if (token.isEmpty) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: 'Token login tidak ditemukan. Silakan login ulang.',
      ));
      return;
    }

    emit(state.copyWith(
      status: ProfileStatus.loading,
      message: '',
    ));

    try {
      final profile = await repository.updateProfile(
        token: token,
        email: event.email,
      );

      userSessionBloc.add(
        SetUserSession(
          token: token,
          name: profile.displayName,
          email: profile.email,
        ),
      );

      emit(state.copyWith(
        status: ProfileStatus.updateSuccess,
        token: token,
        profile: profile,
        message: 'Profil berhasil diperbarui.',
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: _errorMessage(error),
      ));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<ProfileState> emit,
      ) async {
    final token = state.token.isNotEmpty
        ? state.token
        : userSessionBloc.state.token;

    try {
      await repository.logout(token: token);
    } catch (_) {

    }

    userSessionBloc.add(const ClearUserSession());

    emit(const ProfileState(
      status: ProfileStatus.logoutSuccess,
      message: 'Logout berhasil.',
    ));
  }

  String _errorMessage(Object error) {
    if (error is Failure) {
      return error.message;
    }

    return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}