import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch all users.
class FetchUsers extends UserListEvent {
  const FetchUsers();
}
