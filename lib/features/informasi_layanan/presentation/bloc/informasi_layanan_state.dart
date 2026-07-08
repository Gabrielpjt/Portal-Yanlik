import 'package:equatable/equatable.dart';
import '../../domain/entities/informasi_layanan_entity.dart';

enum InformasiLayananStatus { initial, loading, loaded, error }

class InformasiLayananState extends Equatable {
  final InformasiLayananStatus status;
  final List<InformasiLayananEntity> items;
  final String errorMessage;

  const InformasiLayananState({
    this.status = InformasiLayananStatus.initial,
    this.items = const [],
    this.errorMessage = '',
  });

  InformasiLayananState copyWith({
    InformasiLayananStatus? status,
    List<InformasiLayananEntity>? items,
    String? errorMessage,
  }) {
    return InformasiLayananState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage];
}
