import 'package:equatable/equatable.dart';

abstract class AppLoadingEvent extends Equatable {
  const AppLoadingEvent();

  @override
  List<Object?> get props => [];
}

/// Show a global loading overlay with an optional message.
class ShowLoading extends AppLoadingEvent {
  final String? message;

  const ShowLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Hide the global loading overlay.
class HideLoading extends AppLoadingEvent {
  const HideLoading();
}
