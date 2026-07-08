import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exceptions.dart';
import '../models/fasyankes_model.dart';

class ServiceAccessRemoteDatasource {
  final ApiClient apiClient;

  ServiceAccessRemoteDatasource(this.apiClient);

  static const int _fetchAllPageLimit = 5;
  static const int _fetchAllMaxPages = 300;

  Future<List<FasyankesModel>> searchFasyankes({
    required String token,
    required int page,
    required int limit,
    String query = '',
    String jenisSarana = '',
    bool fetchAll = false,
  }) async {
    try {
      if (fetchAll) {
        return _searchAllFasyankes(
          query: query,
          jenisSarana: jenisSarana,
        );
      }

      return _searchFasyankesPage(
        page: page,
        limit: limit,
        query: query,
        jenisSarana: jenisSarana,
      );
    } on DioException catch (error) {
      throw ApiExceptions.fromDioError(error);
    }
  }

  Future<List<FasyankesModel>> _searchAllFasyankes({
    required String query,
    required String jenisSarana,
  }) async {
    final collected = <String, FasyankesModel>{};

    for (var page = 1; page <= _fetchAllMaxPages; page++) {
      final pageItems = await _searchFasyankesPage(
        page: page,
        limit: _fetchAllPageLimit,
        query: query,
        jenisSarana: jenisSarana,
      );

      if (pageItems.isEmpty) {
        break;
      }

      for (final item in pageItems) {
        collected[item.id] = item;
      }

      if (pageItems.length < _fetchAllPageLimit) {
        break;
      }
    }

    return collected.values.toList();
  }

  Future<List<FasyankesModel>> _searchFasyankesPage({
    required int page,
    required int limit,
    required String query,
    required String jenisSarana,
  }) async {
    final queryParameters = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'pagination': 'true',
      if (query.trim().isNotEmpty) 'q': query.trim(),
      if (jenisSarana.trim().isNotEmpty) 'jenis_sarana': jenisSarana.trim(),
    };

    final path = Uri(
      path: '/publik/fasyankes',
      queryParameters: queryParameters,
    ).toString();

    final response = await apiClient.get(
      path,
      options: _publicOptions(),
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
        '/publik/fasyankes/${id.trim()}',
        options: _publicOptions(),
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

  Options _publicOptions() {
    return Options(
      headers: const <String, String>{
        'Accept': 'application/json',
      },
    );
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

    if (data is List) {
      return data;
    }

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
