import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_loading_event.dart';
import 'app_loading_state.dart';

/// Global Bloc that controls a full-screen loading overlay.
///
/// Usage:
/// ```dart
/// // Show loading
/// context.read<AppLoadingBloc>().add(ShowLoading(message: 'Saving...'));
///
/// // Hide loading
/// context.read<AppLoadingBloc>().add(HideLoading());
/// ```
///
/// In your root widget, wrap the body with:
/// ```dart
/// BlocBuilder<AppLoadingBloc, AppLoadingState>(
///   builder: (context, state) {
///     return LoadingOverlay(
///       isLoading: state.isLoading,
///       message: state.message,
///       child: ...,
///     );
///   },
/// )
/// ```
class AppLoadingBloc extends Bloc<AppLoadingEvent, AppLoadingState> {
  AppLoadingBloc() : super(const AppLoadingState()) {
    on<ShowLoading>(_onShowLoading);
    on<HideLoading>(_onHideLoading);
  }

  void _onShowLoading(
    ShowLoading event,
    Emitter<AppLoadingState> emit,
  ) {
    emit(AppLoadingState(isLoading: true, message: event.message));
  }

  void _onHideLoading(
    HideLoading event,
    Emitter<AppLoadingState> emit,
  ) {
    emit(const AppLoadingState());
  }
}
