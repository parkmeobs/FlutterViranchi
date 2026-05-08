
import 'package:flutter_application_1/data/services/api_service.dart';
import 'package:flutter_application_1/data/services/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginResponseModel {
  final String status;
  final String message;

  LoginResponseModel({
    required this.status,
    required this.message,
  });

  factory LoginResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LoginResponseModel(
      status: json['STATUS'] ?? '',
      message: json['MESSAGE'] ?? '',
    );
  }
}



class VerifyOtpResponseModel {
  final String status;
  final String message;
  final String token;

  VerifyOtpResponseModel({
    required this.status,
    required this.message,
    required this.token,
  });

  factory VerifyOtpResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VerifyOtpResponseModel(
      status: json['STATUS'] ?? '',
      message: json['MESSAGE'] ?? '',
      token: json['token'] ?? '',
    );
  }
}


  final randomJokeProvider = FutureProvider<LoginResponseModel>((ref) async {
    final response = await _apiService.post(
      ApiEndpoints.loginSendOtp,
      body: {
        'mobile': mobile,
        'country_code': '91',
        'appHash': appHash,
      },
    );

  return LoginResponseModel.fromJson(response);
});


class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  /// SEND OTP




  /// VERIFY OTP
  Future<VerifyOtpResponseModel> verifyOtp(
    String mobile,
    String otp,
  ) async {

    final response = await _apiService.post(
      ApiEndpoints.verifyOtp,
      body: {
        'mobile': mobile,
        'otp': otp,
      },
    );

    return VerifyOtpResponseModel.fromJson(response);
  }
}