import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/user_repository.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

/// Bloc that fetches all users (no pagination).
///
/// Events:
/// - [FetchUsers]: Load all users at once.
class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository _repository;

  UserListBloc(this._repository) : super(const UserListState()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(
    FetchUsers event,
    Emitter<UserListState> emit,
  ) async {
    emit(state.copyWith(status: UserListStatus.loading));

    final (users, failure) = await _repository.getUsers();

    if (failure != null) {
      emit(state.copyWith(
        status: UserListStatus.error,
        errorMessage: failure.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: UserListStatus.loaded,
      users: users,
    ));
  }
}
