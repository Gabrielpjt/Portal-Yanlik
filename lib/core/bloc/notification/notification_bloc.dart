import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

/// Global Bloc that tracks unread notification count.
///
/// Usage:
/// ```dart
/// // Read count
/// final count = context.watch<NotificationBloc>().state.unreadCount;
///
/// // Update count
/// context.read<NotificationBloc>().add(UpdateNotificationCount(5));
/// ```
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<UpdateNotificationCount>(_onUpdate);
    on<IncrementNotificationCount>(_onIncrement);
    on<ClearNotifications>(_onClear);
  }

  void _onUpdate(
    UpdateNotificationCount event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(unreadCount: event.count));
  }

  void _onIncrement(
    IncrementNotificationCount event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(unreadCount: state.unreadCount + 1));
  }

  void _onClear(
    ClearNotifications event,
    Emitter<NotificationState> emit,
  ) {
    emit(const NotificationState());
  }
}
