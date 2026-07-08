import 'package:dio/dio.dart';
import '../errors/failure.dart';

/// Maps [DioException] types to the app's [Failure] hierarchy.
///
/// Usage:
/// ```dart
/// try {
///   final response = await apiClient.get('/endpoint');
/// } on DioException catch (e) {
///   throw ApiExceptions.fromDioError(e);
/// }
/// ```
class ApiExceptions {
  /// Convert a [DioException] into a domain [Failure].
  static Failure fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timed out. Please try again.');

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response);

      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Invalid server certificate.');

      default:
        return const ServerFailure(
          'An unexpected error occurred. Please try again.',
        );
    }
  }

  /// Map HTTP status codes to specific [Failure] types.
  static Failure _handleStatusCode(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final message = response?.statusMessage ?? 'Unknown error';

    switch (statusCode) {
      case 400:
        return ValidationFailure('Bad request: $message');
      case 401:
        return ServerFailure('Unauthorized: $message');
      case 403:
        return ServerFailure('Forbidden: $message');
      case 404:
        return ServerFailure('Not found: $message');
      case 500:
        return ServerFailure('Internal server error: $message');
      case 502:
        return ServerFailure('Bad gateway: $message');
      case 503:
        return ServerFailure('Service unavailable: $message');
      default:
        return ServerFailure('Error $statusCode: $message');
    }
  }
}
