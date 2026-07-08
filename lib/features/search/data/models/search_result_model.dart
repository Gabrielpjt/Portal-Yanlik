import '../../domain/entities/search_result_entity.dart';

class SearchResultModel extends SearchResultEntity {
  const SearchResultModel({
    required super.id,
    required super.title,
    required super.description,
    required super.module,
    super.link,
    super.cakupan,
    super.dibuatPada,
    super.diubahPada,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Tanpa Judul',
      description: json['description'] as String? ?? '',
      module: json['module'] as String? ?? 'unknown',
      link: json['link'] as String?,
      cakupan: json['cakupan'] as String?,
      dibuatPada: json['dibuat_pada'] as String?,
      diubahPada: json['diubah_pada'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'module': module,
      'link': link,
      'cakupan': cakupan,
      'dibuat_pada': dibuatPada,
      'diubah_pada': diubahPada,
    };
  }
}
