import 'service_access_item_entity.dart';
import 'service_access_type.dart';

class FasyankesEntity extends ServiceAccessItemEntity {
  final String alamat;
  final String deskripsi;
  final String email;
  final String jenisSaranaKode;
  final String jenisSaranaName;
  final String kodeSarana;
  final String kodeSatuSehat;
  final String latitude;
  final String longitude;
  final String nama;
  final String telp;
  final String versiData;
  final String website;

  const FasyankesEntity({
    required super.id,
    required this.alamat,
    required this.deskripsi,
    required this.email,
    required this.jenisSaranaKode,
    required this.jenisSaranaName,
    required this.kodeSarana,
    required this.kodeSatuSehat,
    required this.latitude,
    required this.longitude,
    required this.nama,
    required this.telp,
    required this.versiData,
    required this.website,
  }) : super(type: ServiceAccessSearchType.healthFacility);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'alamat': alamat,
      'deskripsi': deskripsi,
      'email': email,
      'jenis_sarana_kode': jenisSaranaKode,
      'jenis_sarana_name': jenisSaranaName,
      'kode_sarana': kodeSarana,
      'kode_satu_sehat': kodeSatuSehat,
      'latitude': latitude,
      'longitude': longitude,
      'nama': nama,
      'telp': telp,
      'versi_data': versiData,
      'website': website,

      // Alias agar widget Service Access tetap reusable.
      'name': nama,
      'address': alamat,
      'phone': telp,
      'type': jenisSaranaName,
      'facilityType': jenisSaranaName,
      'typeLabel': jenisSaranaName,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    type,
    id,
    alamat,
    deskripsi,
    email,
    jenisSaranaKode,
    jenisSaranaName,
    kodeSarana,
    kodeSatuSehat,
    latitude,
    longitude,
    nama,
    telp,
    versiData,
    website,
  ];
}
