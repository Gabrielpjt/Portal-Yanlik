import 'package:equatable/equatable.dart';

class LayananEntity extends Equatable {
  const LayananEntity();

  @override
  List<Object?> get props => [];
}

enum LayananDetailStatus { initial, loading, loaded, error }

class LayananDetailState extends Equatable {
  final LayananDetailStatus status;
  final LayananEntity? layanan;
  final String errorMessage;

  const LayananDetailState({
    this.status = LayananDetailStatus.initial,
    this.layanan,
    this.errorMessage = '',
  });

  LayananDetailState copyWith({
    LayananDetailStatus? status,
    LayananEntity? layanan,
    String? errorMessage,
  }) {
    return LayananDetailState(
      status: status ?? this.status,
      layanan: layanan ?? this.layanan,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, layanan, errorMessage];
}
