import 'package:equatable/equatable.dart';

/// Domain entity representing a public service information article.
///
/// This is the pure domain object with no serialization logic.
/// See [InformasiLayananModel] for the JSON-aware data layer counterpart.
///
/// Fields are mapped from the `/publik/informasi-layanan` API response.
class InformasiLayananEntity extends Equatable {
  final int id;
  final String judul;
  final String deskripsi;
  final String? imageUrl;
  final String? thumbnailUrl;
  final int kategoriInformasiLayananId;
  final int dibuatOleh;
  final int? diubahOleh;
  final int editor;
  final DateTime? dibuatPada;
  final DateTime? diubahPada;

  const InformasiLayananEntity({
    required this.id,
    required this.judul,
    required this.deskripsi,
    this.imageUrl,
    this.thumbnailUrl,
    required this.kategoriInformasiLayananId,
    required this.dibuatOleh,
    this.diubahOleh,
    required this.editor,
    this.dibuatPada,
    this.diubahPada,
  });

  @override
  List<Object?> get props => [
        id,
        judul,
        deskripsi,
        imageUrl,
        thumbnailUrl,
        kategoriInformasiLayananId,
        dibuatOleh,
        diubahOleh,
        editor,
        dibuatPada,
        diubahPada,
      ];
}
