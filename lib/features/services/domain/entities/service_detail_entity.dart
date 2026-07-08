import 'package:equatable/equatable.dart';

class ServiceDetailEntity extends Equatable {
  final int id;
  final String nama;
  final String deskripsi;
  final String status;
  final String cakupan;
  final String? updatedAt;

  final List<String> aksesLayanan;
  final CategoryLiteEntity? kategoriLayanan;
  final CategoryLiteEntity? kategoriMasterLayanan;
  final MasterLayananLiteEntity? masterLayanan;

  final List<ServiceOrderedItemEntity> persyaratan;
  final List<ServiceOrderedItemEntity> caraMengakses;
  final List<ServiceAccessEntity> akses;
  final List<ServiceComplaintEntity> kanalPengaduan;
  final List<ServiceFaqEntity> faq;
  final ServiceAdditionalInfoEntity? informasiTambahan;

  const ServiceDetailEntity({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.status,
    required this.cakupan,
    this.updatedAt,
    this.aksesLayanan = const [],
    this.kategoriLayanan,
    this.kategoriMasterLayanan,
    this.masterLayanan,
    this.persyaratan = const [],
    this.caraMengakses = const [],
    this.akses = const [],
    this.kanalPengaduan = const [],
    this.faq = const [],
    this.informasiTambahan,
  });

  @override
  List<Object?> get props => [
    id,
    nama,
    deskripsi,
    status,
    cakupan,
    updatedAt,
    aksesLayanan,
    kategoriLayanan,
    kategoriMasterLayanan,
    masterLayanan,
    persyaratan,
    caraMengakses,
    akses,
    kanalPengaduan,
    faq,
    informasiTambahan,
  ];
}

class CategoryLiteEntity extends Equatable {
  final int id;
  final String nama;

  const CategoryLiteEntity({
    required this.id,
    required this.nama,
  });

  @override
  List<Object?> get props => [id, nama];
}

class MasterLayananLiteEntity extends Equatable {
  final int id;
  final String nama;
  final String cakupan;

  const MasterLayananLiteEntity({
    required this.id,
    required this.nama,
    required this.cakupan,
  });

  @override
  List<Object?> get props => [id, nama, cakupan];
}

class ServiceOrderedItemEntity extends Equatable {
  final int id;
  final String judul;
  final String deskripsi;
  final int urutan;

  const ServiceOrderedItemEntity({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.urutan,
  });

  @override
  List<Object?> get props => [id, judul, deskripsi, urutan];
}

class ServiceAccessEntity extends Equatable {
  final int id;
  final String judul;
  final String deskripsi;
  final String tipe;
  final bool isPrimary;

  const ServiceAccessEntity({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.tipe,
    required this.isPrimary,
  });

  @override
  List<Object?> get props => [id, judul, deskripsi, tipe, isPrimary];
}

class ServiceComplaintEntity extends Equatable {
  final int id;
  final String judul;
  final String deskripsi;
  final String tipe;

  const ServiceComplaintEntity({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.tipe,
  });

  @override
  List<Object?> get props => [id, judul, deskripsi, tipe];
}

class ServiceFaqEntity extends Equatable {
  final int id;
  final String pertanyaan;
  final String jawaban;
  final int urutan;

  const ServiceFaqEntity({
    required this.id,
    required this.pertanyaan,
    required this.jawaban,
    required this.urutan,
  });

  @override
  List<Object?> get props => [id, pertanyaan, jawaban, urutan];
}

class ServiceAdditionalInfoEntity extends Equatable {
  final String biayaLayanan;
  final String hasilLayanan;
  final String waktuPenyelesaian;

  const ServiceAdditionalInfoEntity({
    required this.biayaLayanan,
    required this.hasilLayanan,
    required this.waktuPenyelesaian,
  });

  @override
  List<Object?> get props => [
    biayaLayanan,
    hasilLayanan,
    waktuPenyelesaian,
  ];
}