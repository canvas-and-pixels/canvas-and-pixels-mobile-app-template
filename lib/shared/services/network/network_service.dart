import 'dart:io';
import 'package:canvas_and_pixels_mobile_app_template/shared/services/network/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'newtork_error.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  late Dio _dio;

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com', // Change this to your API base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // ✅ Add authentication token if available
          String? token = ''; // Fetch token from secure storage
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          if (kDebugMode) {
            print('➡️ [REQUEST] ${options.method} ${options.path}');
            print('Headers: ${options.headers}');
            print('Body: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('✅ [RESPONSE] ${response.statusCode}: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          if (kDebugMode) {
            print('❌ [ERROR] ${error.message}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// Performs a GET request with functional error handling.
  Future<Result<Response, NetworkError>> get(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return Result.success(response);
    } on DioException catch (e) {
      return Result.failure(_handleDioError(e));
    }
  }

  /// Performs a POST request with functional error handling.
  Future<Result<Response, NetworkError>> post(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return Result.success(response);
    } on DioException catch (e) {
      return Result.failure(_handleDioError(e));
    }
  }

  /// Performs a PUT request.
  Future<Result<Response, NetworkError>> put(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return Result.success(response);
    } on DioException catch (e) {
      return Result.failure(_handleDioError(e));
    }
  }

  /// Performs a DELETE request.
  Future<Result<Response, NetworkError>> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return Result.success(response);
    } on DioException catch (e) {
      return Result.failure(_handleDioError(e));
    }
  }

  /// Handles Dio exceptions and returns appropriate functional errors.
  NetworkError _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return const TimeoutError();
    } else if (error.type == DioExceptionType.connectionError) {
      return const NoInternetError();
    } else if (error.response != null) {
      return ServerError(error.response!.statusCode ?? 500,
          error.response?.data.toString() ?? 'Server error');
    } else {
      return const UnknownError();
    }
  }
}
