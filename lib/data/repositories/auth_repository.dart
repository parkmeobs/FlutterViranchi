import 'package:flutter_application_1/data/services/api_service.dart';
import 'package:flutter_application_1/data/services/api_endpoints.dart';

class AuthRepository {
  final ApiService _apiService;
  AuthRepository(this._apiService);

  Future<Map<String, dynamic>> login(String mobile, String appHash) async {
    final response = await _apiService.post(
      ApiEndpoints.loginSendOtp, 
      body: { // ⬅️ Add 'body:' here
        'mobile': mobile,
        'country_code': '91',
        'appHash': appHash,
      },
    );
    return response; // Note: In the merged ApiService, we already return response.data
  }

  Future<String> verifyOtp(String mobile, String otp) async {
    final response = await _apiService.post(
      ApiEndpoints.verifyOtp, 
      body: { // ⬅️ Add 'body:' here
        'mobile': mobile,
        'otp': otp,
      },
    );
    return response['token']; 
  }
}