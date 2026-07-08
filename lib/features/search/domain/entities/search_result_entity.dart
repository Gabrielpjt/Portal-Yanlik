import 'package:equatable/equatable.dart';

/// Unified search result entity from /search API
class SearchResultEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String module; // 'layanan' or 'informasi_layanan'
  final String? link;
  final String? cakupan;
  final String? dibuatPada;
  final String? diubahPada;

  const SearchResultEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.module,
    this.link,
    this.cakupan,
    this.dibuatPada,
    this.diubahPada,
  });

  /// Check if this is a layanan result
  bool get isLayanan => module == 'layanan';

  /// Check if this is an informasi layanan result
  bool get isInformasiLayanan => module == 'informasi_layanan';

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        module,
        link,
        cakupan,
        dibuatPada,
        diubahPada,
      ];
}
