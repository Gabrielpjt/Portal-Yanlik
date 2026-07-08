import '../../domain/entities/service_detail_entity.dart';

class ServiceDetailModel extends ServiceDetailEntity {
  const ServiceDetailModel({
    required super.id,
    required super.nama,
    required super.deskripsi,
    required super.status,
    required super.cakupan,
    super.updatedAt,
    super.aksesLayanan,
    super.kategoriLayanan,
    super.kategoriMasterLayanan,
    super.masterLayanan,
    super.persyaratan,
    super.caraMengakses,
    super.akses,
    super.kanalPengaduan,
    super.faq,
    super.informasiTambahan,
  });

  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailModel(
      id: _toInt(json['id']),
      nama: _toString(json['nama']),
      deskripsi: _toString(json['deskripsi']),
      status: _toString(json['status']),
      cakupan: _toString(json['cakupan']),
      updatedAt: _nullableString(json['tgl_diubah'] ?? json['diubah_pada']),
      aksesLayanan: _toStringList(json['akses_layanan']),
      kategoriLayanan: _categoryFromJson(json['kategori_layanan']),
      kategoriMasterLayanan: _categoryFromJson(
        json['kategori_master_layanan'],
      ),
      masterLayanan: _masterLayananFromJson(json['master_layanan']),
      persyaratan: _orderedItemsFromJson(json['layanan_persyaratan']),
      caraMengakses: _orderedItemsFromJson(json['layanan_cara_mengakses']),
      akses: _accessFromJson(json['layanan_akses']),
      kanalPengaduan: _complaintsFromJson(json['layanan_kanal_pengaduan']),
      faq: _faqFromJson(json['layanan_faq']),
      informasiTambahan: _additionalInfoFromJson(
        json['layanan_informasi_tambahan'],
      ),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _toString(dynamic value) {
    return value?.toString() ?? '';
  }

  static String? _nullableString(dynamic value) {
    final text = value?.toString();
    if (text == null || text.trim().isEmpty) return null;
    return text;
  }

  static List<String> _toStringList(dynamic value) {
    if (value is! List) return const [];
    return value.map((item) => item.toString()).toList();
  }

  static List<Map<String, dynamic>> _toMapList(dynamic value) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static CategoryLiteEntity? _categoryFromJson(dynamic value) {
    if (value is! Map) return null;

    final json = Map<String, dynamic>.from(value);

    return CategoryLiteEntity(
      id: _toInt(json['id']),
      nama: _toString(json['nama']),
    );
  }

  static MasterLayananLiteEntity? _masterLayananFromJson(dynamic value) {
    if (value is! Map) return null;

    final json = Map<String, dynamic>.from(value);

    return MasterLayananLiteEntity(
      id: _toInt(json['id']),
      nama: _toString(json['nama']),
      cakupan: _toString(json['cakupan']),
    );
  }

  static List<ServiceOrderedItemEntity> _orderedItemsFromJson(dynamic value) {
    final items = _toMapList(value)
        .map(
          (json) => ServiceOrderedItemEntity(
        id: _toInt(json['id']),
        judul: _toString(json['judul']),
        deskripsi: _toString(json['deskripsi']),
        urutan: _toInt(json['urutan']),
      ),
    )
        .toList();

    items.sort((a, b) => a.urutan.compareTo(b.urutan));
    return items;
  }

  static List<ServiceAccessEntity> _accessFromJson(dynamic value) {
    return _toMapList(value)
        .map(
          (json) => ServiceAccessEntity(
        id: _toInt(json['id']),
        judul: _toString(json['judul']),
        deskripsi: _toString(json['deskripsi']),
        tipe: _toString(json['tipe']),
        isPrimary: json['is_primary'] == true,
      ),
    )
        .toList();
  }

  static List<ServiceComplaintEntity> _complaintsFromJson(dynamic value) {
    return _toMapList(value)
        .map(
          (json) => ServiceComplaintEntity(
        id: _toInt(json['id']),
        judul: _toString(json['judul']),
        deskripsi: _toString(json['deskripsi']),
        tipe: _toString(json['tipe']),
      ),
    )
        .toList();
  }

  static List<ServiceFaqEntity> _faqFromJson(dynamic value) {
    final items = _toMapList(value)
        .map(
          (json) => ServiceFaqEntity(
        id: _toInt(json['id']),
        pertanyaan: _toString(json['pertanyaan']),
        jawaban: _toString(json['jawaban']),
        urutan: _toInt(json['urutan']),
      ),
    )
        .toList();

    items.sort((a, b) => a.urutan.compareTo(b.urutan));
    return items;
  }

  static ServiceAdditionalInfoEntity? _additionalInfoFromJson(dynamic value) {
    if (value is! Map) return null;

    final json = Map<String, dynamic>.from(value);

    return ServiceAdditionalInfoEntity(
      biayaLayanan: _toString(json['biaya_layanan']),
      hasilLayanan: _toString(json['hasil_layanan']),
      waktuPenyelesaian: _toString(json['waktu_penyelesaian']),
    );
  }
}