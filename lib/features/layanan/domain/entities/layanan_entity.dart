import 'package:equatable/equatable.dart';

class LayananEntity extends Equatable {
  final int id;
  final String nama;
  final String deskripsi;
  final String? ikonLayanan;

  const LayananEntity({
    required this.id,
    required this.nama,
    required this.deskripsi,
    this.ikonLayanan,
  });

  @override
  List<Object?> get props => [id, nama, deskripsi, ikonLayanan];
}
