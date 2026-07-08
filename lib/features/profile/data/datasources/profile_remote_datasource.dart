import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exceptions.dart';
import '../models/login_response_model.dart';
import '../models/user_profile_model.dart';

class ProfileRemoteDatasource {
  final ApiClient apiClient;

  ProfileRemoteDatasource(this.apiClient);

  Future<LoginResponseModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        '/pengguna/login',
        data: {
          'username': username,
          'password': password,
          'otpType': 'email',
          'token': '',
        },
      );

      final body = _readResponseBody(response.data);
      _throwIfFailed(body, fallbackMessage: 'Login gagal.');

      return LoginResponseModel.fromProxyJson(body);
    } on DioException catch (error) {
      throw ApiExceptions.fromDioError(error);
    }
  }

  Future<UserProfileModel> getProfile({
    required String token,
  }) async {
    try {
      final response = await apiClient.get(
        '/pengguna/profile',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      final body = _readResponseBody(response.data);
      _throwIfFailed(body, fallbackMessage: 'Gagal mengambil profil.');

      return UserProfileModel.fromProxyJson(body);
    } on DioException catch (error) {
      throw ApiExceptions.fromDioError(error);
    }
  }

  Future<UserProfileModel> updateProfile({
    required String token,
    required String email,
  }) async {
    try {
      final response = await apiClient.put(
        '/pengguna/profile-update',
        data: {
          'email': email,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      final body = _readResponseBody(response.data);
      _throwIfFailed(body, fallbackMessage: 'Gagal memperbarui profil.');

      return UserProfileModel.fromProxyJson(body);
    } on DioException catch (error) {
      throw ApiExceptions.fromDioError(error);
    }
  }

  Future<void> logout({
    String? token,
  }) async {
    try {
      await apiClient.post(
        '/pengguna/logout',
        data: {},
        options: token == null || token.isEmpty
            ? null
            : Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
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