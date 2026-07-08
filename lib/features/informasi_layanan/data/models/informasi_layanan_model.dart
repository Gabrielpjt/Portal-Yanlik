import '../../domain/entities/informasi_layanan_entity.dart';

/// Data model for Informasi Layanan with JSON serialization.
///
/// Extends [InformasiLayananEntity] and adds `fromJson` / `toJson`.
///
/// Example JSON (from `/publik/informasi-layanan`):
/// ```json
/// {
///   "id": 1,
///   "judul": "Pembuatan KTP Elektronik",
///   "deskripsi": "Informasi lengkap mengenai prosedur pembuatan KTP elektronik",
///   "image_url": "https://cdn.example.com/layanan/ktp.jpg",
///   "thumbnail_url": "https://cdn.example.com/layanan/ktp-thumb.jpg",
///   "kategori_informasi_layanan_id": 1,
///   "dibuat_oleh": 1,
///   "diubah_oleh": 1,
///   "editor": 1,
///   "dibuat_pada": "2024-01-01T10:00:00+07:00",
///   "diubah_pada": "2024-01-01T10:00:00+07:00"
/// }
/// ```
class InformasiLayananModel extends InformasiLayananEntity {
  const InformasiLayananModel({
    required super.id,
    required super.judul,
    required super.deskripsi,
    super.imageUrl,
    super.thumbnailUrl,
    required super.kategoriInformasiLayananId,
    required super.dibuatOleh,
    super.diubahOleh,
    required super.editor,
    super.dibuatPada,
    super.diubahPada,
  });

  factory InformasiLayananModel.fromJson(Map<String, dynamic> json) {
    return InformasiLayananModel(
      id: json['id'] as int,
      judul: json['judul'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      kategoriInformasiLayananId:
          json['kategori_informasi_layanan_id'] as int? ?? 0,
      dibuatOleh: json['dibuat_oleh'] as int? ?? 0,
      diubahOleh: json['diubah_oleh'] as int?,
      editor: json['editor'] as int? ?? 0,
      dibuatPada: json['dibuat_pada'] != null
          ? DateTime.tryParse(json['dibuat_pada'] as String)
          : null,
      diubahPada: json['diubah_pada'] != null
          ? DateTime.tryParse(json['diubah_pada'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'image_url': imageUrl,
      'thumbnail_url': thumbnailUrl,
      'kategori_informasi_layanan_id': kategoriInformasiLayananId,
      'dibuat_oleh': dibuatOleh,
      'diubah_oleh': diubahOleh,
      'editor': editor,
      'dibuat_pada': dibuatPada?.toIso8601String(),
      'diubah_pada': diubahPada?.toIso8601String(),
    };
  }
}
