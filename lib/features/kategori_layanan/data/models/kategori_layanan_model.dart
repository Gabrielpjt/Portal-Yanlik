import '../../../layanan/data/models/layanan_model.dart';
import '../../domain/entities/kategori_layanan_entity.dart';

class KategoriLayananModel extends KategoriLayananEntity {
  const KategoriLayananModel({
    required super.id,
    required super.nama,
    super.ikon,
    required super.jumlahLayanan,
    super.layanan = const [],
  });

  factory KategoriLayananModel.fromJson(Map<String, dynamic> json) {
    // The API returns a 'layanan' array inside each category.
    final layananList = json['layanan'] as List<dynamic>? ?? [];
    
    return KategoriLayananModel(
      id: json['id'] as int,
      nama: json['nama'] as String,
      ikon: json['ikon'] as String?,
      jumlahLayanan: layananList.length,
      layanan: layananList
          .map((e) => LayananModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
