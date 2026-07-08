import 'package:equatable/equatable.dart';

class AppLoadingState extends Equatable {
  final bool isLoading;
  final String? message;

  const AppLoadingState({
    this.isLoading = false,
    this.message,
  });

  AppLoadingState copyWith({
    bool? isLoading,
    String? message,
  }) {
    return AppLoadingState(
      isLoading: isLoading ?? this.isLoading,
      message: message,
    );
  }

  @override
  List<Object?> get props => [isLoading, message];
}
