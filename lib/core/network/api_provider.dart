import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter_project/core/constants/api_constants.dart';

import '../errors/exceptions.dart';
import '../utils/secure_storage_helper.dart';

class ApiProvider {
  final Dio _dio;

  ApiProvider() : _dio = Dio() {
    _dio.options
      ..baseUrl = ApiConstants.baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..validateStatus = (status) => status! < 500;

    _dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageHelper(const FlutterSecureStorage())
              .getString(ApiConstants.tokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    ]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Response _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response;
    } else {
      throw ServerException(
        response.data['message'] ?? 'An error occurred',
      );
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ServerException('Connection timeout');
      case DioExceptionType.connectionError:
        return ServerException('No internet connection');
      default:
        return ServerException(e.message ?? 'An error occurred');
    }
  }
}
