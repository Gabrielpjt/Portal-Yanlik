import 'package:equatable/equatable.dart';
import '../../domain/entities/kategori_layanan_entity.dart';

enum KategoriLayananStatus { initial, loading, loaded, error }

class KategoriLayananState extends Equatable {
  final KategoriLayananStatus status;
  final List<KategoriLayananEntity> items;
  final String errorMessage;

  const KategoriLayananState({
    this.status = KategoriLayananStatus.initial,
    this.items = const [],
    this.errorMessage = '',
  });

  KategoriLayananState copyWith({
    KategoriLayananStatus? status,
    List<KategoriLayananEntity>? items,
    String? errorMessage,
  }) {
    return KategoriLayananState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, items, errorMessage];
}
