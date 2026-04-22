import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/services/api_service.dart';
import '../../../data/repositories/auth_repository.dart';

// State class to replace AuthState interface
class AuthState {
  final bool loginLoading;
  final bool verifyOtpLoading;
  final String? token;

  AuthState({this.loginLoading = false, this.verifyOtpLoading = false, this.token});

  AuthState copyWith({bool? loginLoading, bool? verifyOtpLoading, String? token}) {
    return AuthState(
      loginLoading: loginLoading ?? this.loginLoading,
      verifyOtpLoading: verifyOtpLoading ?? this.verifyOtpLoading,
      token: token ?? this.token,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final ApiService _apiService;

  AuthViewModel(this._repository, this._apiService) : super(AuthState());

  // handleLogin logic
  Future<bool> handleLogin(String mobile, String appHash) async {
    state = state.copyWith(loginLoading: true);
    try {
      final res = await _repository.login(mobile, appHash);
      state = state.copyWith(loginLoading: false);
      print("Login Response: $res");
      return res['STATUS'] == 'Success';
    } catch (e) {
      state = state.copyWith(loginLoading: false);
      return false;
    }
  }

  // verifyOtp logic
  Future<void> submitOtp(String mobile, String otp) async {
    state = state.copyWith(verifyOtpLoading: true);
    try {
      final token = await _repository.verifyOtp(mobile, otp);
      _apiService.updateHeaderToken(token); // Update Dio headers
      state = state.copyWith(verifyOtpLoading: false, token: token);
    } catch (e) {
      state = state.copyWith(verifyOtpLoading: false);
    }
  }
}

// Provider
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final service = ref.watch(apiServiceProvider);
  return AuthViewModel(AuthRepository(service), service);
});