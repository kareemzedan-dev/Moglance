import 'package:dio/dio.dart';

class ApiManager {
  final Dio _dio;

  ApiManager({required String baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  // GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'GET request error: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }

  // POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await _dio.post(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'POST request error: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }

  // PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await _dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'PUT request error: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'DELETE request error: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }
}
