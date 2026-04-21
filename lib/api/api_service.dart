import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  // Common headers
  Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // 🔹 GET
  Future<dynamic> get(
    String endpoint, {
    String? token,
  }) async {
    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
    );

    return _handleResponse(response);
  }

  // 🔹 POST
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  // 🔹 PUT
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  // 🔹 PATCH
  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final response = await http.patch(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  // 🔹 DELETE
  Future<dynamic> delete(
    String endpoint, {
    String? token,
  }) async {
    final response = await http.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
    );

    return _handleResponse(response);
  }

  // 🔹 Response Handler (VERY IMPORTANT)
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    final responseBody =
        response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return responseBody;
    } else if (statusCode == 401) {
      throw Exception("Unauthorized (401)");
    } else if (statusCode == 404) {
      throw Exception("Not Found (404)");
    } else if (statusCode == 500) {
      throw Exception("Server Error (500)");
    } else {
      throw Exception(
        "Error: $statusCode, ${response.reasonPhrase}",
      );
    }
  }
}