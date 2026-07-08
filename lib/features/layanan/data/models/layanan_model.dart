import '../../domain/entities/layanan_entity.dart';

class LayananModel extends LayananEntity {
  const LayananModel({
    required super.id,
    required super.nama,
    required super.deskripsi,
    super.ikonLayanan,
  });

  factory LayananModel.fromJson(Map<String, dynamic> json) {
    return LayananModel(
      id: json['id'] as int,
      nama: json['nama'] as String? ?? 'Tanpa Nama',
      deskripsi: json['deskripsi'] as String? ?? '',
      ikonLayanan: json['ikon_layanan'] as String?,
    );
  }
}
