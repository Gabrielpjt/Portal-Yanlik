import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exceptions.dart';
import '../models/fasyankes_model.dart';

class ServiceAccessRemoteDatasource {
  final ApiClient apiClient;

  ServiceAccessRemoteDatasource(this.apiClient);

  Future<List<FasyankesModel>> searchFasyankes({
    required String token,
    required int page,
    required int limit,
    String query = '',
    String jenisSarana = '',
  }) async {
    try {
      final path = Uri(
        path: '/fasyankes',
        queryParameters: <String, String>{
          'page': page.toString(),
          'limit': limit.toString(),
          'pagination': 'true',
          'q': query,
          'jenis_sarana': jenisSarana,
        },
      ).toString();

      final response = await apiClient.get(
        path,
        options: _options(token),
      );

      final body = _readResponseBody(response.data);

      _throwIfFailed(
        body,
        fallbackMessage: 'Gagal mengambil fasilitas kesehatan.',
      );

      final listData = _extractListData(body);

      return listData
          .whereType<Map>()
          .map(
            (item) => FasyankesModel.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
          .toList();
    } on DioException catch (error) {
      throw ApiExceptions.fromDioError(error);
    }
  }

  Future<FasyankesModel> getFasyankesDetail({
    required String token,
    required String id,
  }) async {
    if (id.trim().isEmpty) {
      throw const ServerFailure('ID fasilitas kesehatan tidak ditemukan.');
    }

    try {
      final response = await apiClient.get(
        '/fasyankes/$id',
        options: _options(token),
      );

      final body = _readResponseBody(response.data);

      _throwIfFailed(
        body,
        fallbackMessage: 'Gagal mengambil detail fasilitas kesehatan.',
      );

      final data = _extractDetailData(body);

      return FasyankesModel.fromJson(data);
    } on DioException catch (error) {
      throw ApiExceptions.fromDioError(error);
    }
  }

  Options _options(String token) {
    final headers = <String, String>{
      'Accept': 'application/json',
    };

    // Token optional.
    // Kalau user belum login, Authorization tidak dikirim.
    // Kalau user sudah login, token dikirim.
    if (token.trim().isNotEmpty) {
      headers['Authorization'] = token;
    }

    return Options(headers: headers);
  }

  Map<String, dynamic> _readResponseBody(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    if (data is String && data.trim().isNotEmpty) {
      final decoded = jsonDecode(data);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    }

    throw const ServerFailure('Format response API tidak sesuai.');
  }

  List<dynamic> _extractListData(Map<String, dynamic> body) {
    final data = body['data'];

    // Format contoh Swagger:
    // { "data": [ ... ] }
    if (data is List) {
      return data;
    }

    // Format kemungkinan lain:
    // { "data": { "data": [ ... ] } }
    if (data is Map) {
      final dataMap = Map<String, dynamic>.from(data);

      final nestedData = dataMap['data'];
      if (nestedData is List) {
        return nestedData;
      }

      final items = dataMap['items'];
      if (items is List) {
        return items;
      }

      final rows = dataMap['rows'];
      if (rows is List) {
        return rows;
      }

      final results = dataMap['results'];
      if (results is List) {
        return results;
      }
    }

    throw const ServerFailure('Format data fasilitas kesehatan tidak sesuai.');
  }

  Map<String, dynamic> _extractDetailData(Map<String, dynamic> body) {
    final data = body['data'];

    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    throw const ServerFailure('Format detail fasilitas kesehatan tidak sesuai.');
  }

  void _throwIfFailed(
      Map<String, dynamic> body, {
        required String fallbackMessage,
      }) {
    final success = body['success'];

    if (success == false) {
      throw ServerFailure(
        body['message']?.toString() ?? fallbackMessage,
      );
    }
  }
}