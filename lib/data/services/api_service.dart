import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/services/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

final talker = Talker();

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
/// Merged ApiService handling Base URLs, Interceptors, and CRUD operations.
class ApiService {
  // Use the Base URL from your Endpoints config
  static const String baseUrl = ApiEndpoints.baseUrl;

  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20), // Matches your JS timeout
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          "Content-Type": "application/json",
          "X-Custom-Header": "foobar", // From your JS config
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Logic from your setAccessToken:
          // If token exists, we attach it.
          // In Flutter, you'd usually fetch this from Secure Storage or a Provider.
          print("➡️ Request: ${options.method} ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("✅ Response: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // 401 Session Expired Logic (from your JS interceptor)
          if (e.response?.statusCode == 401) {
            print("🚨 Session Expired: Triggering Logout...");
            // TODO: Call your logout logic/AuthViewModel here
          }
          return handler.next(e);
        },
      ),
    );
    _dio.interceptors.add(
  TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseData: true,
    ),
  ),
);
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) {
    //       // You can attach token here globally
    //       print("➡️ Request: ${options.method} ${options.path}");
    //       return handler.next(options);
    //     },
    //     onResponse: (response, handler) {
    //       print("✅ Response: ${response.statusCode}");
    //       return handler.next(response);
    //     },
    //     onError: (DioException e, handler) {
    //       print("❌ Error: ${e.message}");
    //       return handler.next(e);
    //     },
    //   ),
    // );
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) {
    //       String token = "YOUR_TOKEN";

    //       if (token.isNotEmpty) {
    //         options.headers["Authorization"] = "Bearer $token";
    //       }

    //       return handler.next(options);
    //     },
    //   ),
    // );
  }

  /// Dynamic Token Setter (Equivalent to your JS setAccessToken)
  void updateHeaderToken(String? token) {
    if (token == null || token.isEmpty) {
      _dio.options.headers.remove("Authorization");
    } else {
      // Your JS used `Token ${token}`, but sometimes APIs use `Bearer`.
      // Based on your JS code:
      _dio.options.headers["Authorization"] = "Token $token";
    }
  }

  // 🔹 GET
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 🔹 POST
  Future<dynamic> post(String endpoint, {dynamic body}) async {
    try {
      final response = await _dio.post(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 🔹 PUT
  Future<dynamic> put(String endpoint, {dynamic body}) async {
    try {
      final response = await _dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 🔹 DELETE
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 🔹 Error Handler (Enhanced with your JS logic)
  Exception _handleError(DioException e) {
    if (e.response != null) {
      // This maps to your JS: error?.response?.data?.message
      final String errorMessage =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          "Something went wrong";

      final statusCode = e.response?.statusCode;

      switch (statusCode) {
        case 400:
          return Exception("Bad Request: $errorMessage");
        case 401:
          return Exception("Unauthorized: $errorMessage");
        case 404:
          return Exception("Not Found (404)");
        case 500:
          return Exception("Server Error (500)");
        default:
          return Exception(errorMessage);
      }
    } else {
      return Exception("Network Error: ${e.message}");
    }
  }
}
