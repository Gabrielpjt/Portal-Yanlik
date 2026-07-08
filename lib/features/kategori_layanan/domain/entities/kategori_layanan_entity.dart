import 'package:equatable/equatable.dart';
import '../../../layanan/domain/entities/layanan_entity.dart';

class KategoriLayananEntity extends Equatable {
  final int id;
  final String nama;
  final String? ikon;
  final int jumlahLayanan;
  final List<LayananEntity> layanan;

  const KategoriLayananEntity({
    required this.id,
    required this.nama,
    this.ikon,
    required this.jumlahLayanan,
    this.layanan = const [],
  });

  @override
  List<Object?> get props => [id, nama, ikon, jumlahLayanan, layanan];
}
