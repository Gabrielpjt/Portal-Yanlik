import '../../domain/entities/fasyankes_entity.dart';

class FasyankesModel extends FasyankesEntity {
  const FasyankesModel({
    required super.id,
    required super.alamat,
    required super.deskripsi,
    required super.email,
    required super.jenisSaranaKode,
    required super.jenisSaranaName,
    required super.kodeSarana,
    required super.kodeSatuSehat,
    required super.latitude,
    required super.longitude,
    required super.nama,
    required super.telp,
    required super.versiData,
    required super.website,
  });

  factory FasyankesModel.fromJson(Map<String, dynamic> json) {
    String value(String key) => json[key]?.toString() ?? '';

    return FasyankesModel(
      id: value('id'),
      alamat: value('alamat'),
      deskripsi: value('deskripsi'),
      email: value('email'),
      jenisSaranaKode: value('jenis_sarana_kode'),
      jenisSaranaName: value('jenis_sarana_name'),
      kodeSarana: value('kode_sarana'),
      kodeSatuSehat: value('kode_satu_sehat'),
      latitude: value('latitude'),
      longitude: value('longitude'),
      nama: value('nama'),
      telp: value('telp'),
      versiData: value('versi_data'),
      website: value('website'),
    );
  }

  Map<String, dynamic> toJson() {
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
    };
  }
}
