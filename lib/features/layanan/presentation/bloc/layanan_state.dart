import 'package:equatable/equatable.dart';
import '../../domain/entities/layanan_entity.dart';

enum LayananStatus { initial, loading, loaded, error }

class LayananState extends Equatable {
  final LayananStatus status;
  final List<LayananEntity> items;
  final String errorMessage;

  const LayananState({
    this.status = LayananStatus.initial,
    this.items = const [],
    this.errorMessage = '',
  });

  LayananState copyWith({
    LayananStatus? status,
    List<LayananEntity>? items,
    String? errorMessage,
  }) {
    return LayananState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, items, errorMessage];
}
