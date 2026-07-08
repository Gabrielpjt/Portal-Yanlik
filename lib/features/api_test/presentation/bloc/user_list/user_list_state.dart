import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

enum UserListStatus { initial, loading, loaded, error }

class UserListState extends Equatable {
  final UserListStatus status;
  final List<UserEntity> users;
  final String errorMessage;

  const UserListState({
    this.status = UserListStatus.initial,
    this.users = const [],
    this.errorMessage = '',
  });

  UserListState copyWith({
    UserListStatus? status,
    List<UserEntity>? users,
    String? errorMessage,
  }) {
    return UserListState(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, users, errorMessage];
}
