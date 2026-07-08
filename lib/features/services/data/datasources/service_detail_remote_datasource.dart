import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exceptions.dart';
import '../models/service_detail_model.dart';

class ServiceDetailRemoteDatasource {
  final ApiClient _apiClient;

  ServiceDetailRemoteDatasource(this._apiClient);

  Future<ServiceDetailModel> getDetail(int id) async {
    if (id <= 0) {
      throw const ServerFailure('ID layanan tidak valid.');
    }

    try {
      final response = await _apiClient.get('/publik/layanan/$id');
      final body = _readResponseBody(response.data);

      _throwIfFailed(
        body,
        fallbackMessage: 'Gagal mengambil detail layanan.',
      );

      final data = _extractDetailData(body);

      return ServiceDetailModel.fromJson(data);
    } on DioException catch (error) {
      throw ApiExceptions.fromDioError(error);
    }
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

  Map<String, dynamic> _extractDetailData(Map<String, dynamic> body) {
    final data = body['data'];

    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    throw const ServerFailure('Format detail layanan tidak sesuai.');
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
