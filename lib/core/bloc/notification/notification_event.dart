import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

/// Update the global unread notification count.
class UpdateNotificationCount extends NotificationEvent {
  final int count;

  const UpdateNotificationCount(this.count);

  @override
  List<Object?> get props => [count];
}

/// Increment the unread count by one (e.g. when a push arrives).
class IncrementNotificationCount extends NotificationEvent {
  const IncrementNotificationCount();
}

/// Reset the count to zero (e.g. user opened notification center).
class ClearNotifications extends NotificationEvent {
  const ClearNotifications();
}
