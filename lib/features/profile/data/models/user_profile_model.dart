import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.id,
    required super.username,
    required super.email,
    super.instansiId,
    super.instansiName,
    super.peranId,
    super.peranLabel,
  });

  factory UserProfileModel.fromProxyJson(Map<String, dynamic> json) {
    dynamic rawData = json['data'] ?? json;

    if (rawData is Map && rawData['pengguna'] is Map) {
      rawData = rawData['pengguna'];
    }

    if (rawData is Map && rawData['user'] is Map) {
      rawData = rawData['user'];
    }

    final data = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : <String, dynamic>{};

    final instansi = _asMap(data['instansi']);
    final peran = _asMap(data['peran']);

    return UserProfileModel(
      id: _toInt(data['id']),
      username: data['username']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      instansiId: _toInt(data['instansi_id']),
      instansiName: instansi?['nama']?.toString(),
      peranId: _toInt(data['peran_id']),
      peranLabel: peran?['label_peran']?.toString(),
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return null;
  }

  static int? _toInt(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString());
  }
}