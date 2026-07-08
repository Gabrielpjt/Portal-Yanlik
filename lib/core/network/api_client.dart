import 'package:dio/dio.dart';
import '../../app/config/app_config.dart';
import '../utils/logger.dart';

/// Reusable API client built on top of [Dio].
///
/// Provides a pre-configured Dio instance with:
/// - Base URL from [AppConfig]
/// - Timeout settings
/// - Logging interceptor (debug only)
/// - Auth token interceptor placeholder
///
/// Usage:
/// ```dart
/// final client = ApiClient();
/// final response = await client.get('/posts');
/// ```
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig().baseUrl,
        connectTimeout: Duration(milliseconds: AppConfig().apiTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig().apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Logging interceptor (debug only)
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => Logger.log(obj.toString(), tag: 'API'),
      ),
    );

    // Auth token interceptor placeholder
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO: Read token from secure storage and attach
          // final token = await secureStorage.read(key: 'auth_token');
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        onError: (error, handler) {
          // TODO: Handle 401 unauthorized (refresh token / redirect to login)
          return handler.next(error);
        },
      ),
    );
  }

  /// Access the raw [Dio] instance for advanced usage.
  Dio get dio => _dio;

  /// Override the base URL at runtime.
  ///
  /// Useful for pointing to a different server (e.g. JSONPlaceholder for testing).
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  /// Perform a GET request.
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  /// Perform a POST request.
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

  /// Perform a PUT request.
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put(path, data: data, queryParameters: queryParameters, options: options);
  }

  /// Perform a DELETE request.
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
  }
}
