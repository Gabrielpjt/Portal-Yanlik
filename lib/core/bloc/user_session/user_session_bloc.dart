import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_session_event.dart';
import 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  UserSessionBloc() : super(const UserSessionState()) {
    on<SetUserSession>(_onSetUserSession);
    on<ClearUserSession>(_onClearUserSession);
  }

  void _onSetUserSession(
      SetUserSession event,
      Emitter<UserSessionState> emit,
      ) {
    emit(state.copyWith(
      isAuthenticated: true,
      token: event.token,
      name: event.name,
      email: event.email,
      avatarUrl: event.avatarUrl,
    ));
  }

  void _onClearUserSession(
      ClearUserSession event,
      Emitter<UserSessionState> emit,
      ) {
    emit(const UserSessionState());
  }
}