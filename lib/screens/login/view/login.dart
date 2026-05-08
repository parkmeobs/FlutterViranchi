import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. Added Riverpod
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_application_1/components/custom_button_with_image.dart';
import 'package:flutter_application_1/constants/app_images.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/screens/login/viewmodal/loginviewmodal.dart'; // Import your viewmodel

// 2. Changed to ConsumerStatefulWidget
class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> with CodeAutoFill {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool showOtp = false;
  String error = '';
  String otpError = '';

  int timer = 60;
  bool isResendDisabled = true;
  Timer? countdownTimer;
  bool hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void dispose() {
    cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  void codeUpdated() {
    if (code != null && code!.length == 4 && !hasSubmitted) {
      hasSubmitted = true;
      otpController.text = code!;
      handleSubmitOtp(code!);
    }
  }

  void startTimer() {
    timer = 60;
    isResendDisabled = true;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timerObj) {
      if (timer == 0) {
        timerObj.cancel();
        setState(() => isResendDisabled = false);
      } else {
        setState(() => timer--);
      }
    });
  }

  // ✅ REAL LOGIN API CALL
  void handleLogin() async {
    final number = mobileController.text;

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(number)) {
      setState(() => error = "Enter valid mobile number");
      return;
    }

    setState(() => error = '');

    // Get App Hash for SMS Autofill (equivalent to your appHash in JS)
    String appHash = await SmsAutoFill().getAppSignature;

    // Call the ViewModel
    // final success = await ref.read(authViewModelProvider.notifier).handleLogin(
    //       number,
    //       appHash,
    //     );

    //     print("login sueccess"+"$success");


    // if (success) {
    //   setState(() => showOtp = true);
    //   startTimer();
    // } else {
    //   setState(() => error = "Failed to send OTP. Try again.");
    // }
  }

  // ✅ REAL SUBMIT OTP CALL
  void handleSubmitOtp(String otp) async {
    if (otp.length != 4) {
      setState(() => otpError = "Enter valid OTP");
      return;
    }

    setState(() => otpError = '');

    // Call verify in ViewModel
    // await ref.read(authViewModelProvider.notifier).submitOtp(
    //       mobileController.text,
    //       otp,
    //     );

    // // Watch the result from state
    // final authState = ref.read(authViewModelProvider);
    
    // if (authState.token != null) {
    //   // Success! Navigate to home
    //   if (mounted) context.go('/home');
    // } else {
    //   setState(() => otpError = "Invalid OTP");
    //   hasSubmitted = false;
    // }
  }

  void resendOtp() {
    otpController.clear();
    hasSubmitted = false;
    handleLogin();
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Future<bool> onBackPressed() async {
    if (showOtp) {
      setState(() {
        showOtp = false;
        otpController.clear();
        otpError = '';
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // 3. Listen to the auth state (loading/token)
    // final authState = ref.watch(authViewModelProvider);

    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Column(
                  children: [
                    Image.asset(AppImages.swastik, height: 120),
                    const SizedBox(height: 10),
                    Image.asset(AppImages.viranchiText, height: 30),
                  ],
                ),
                const SizedBox(height: 40),

                if (showOtp) ...[
                  const Text("Enter Code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sent to +91 ${mobileController.text}"),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        onPressed: () => setState(() => showOtp = false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    controller: otpController,
                    length: 4,
                    onCompleted: (value) => handleSubmitOtp(value),
                  ),
                  if (otpError.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(otpError, style: const TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive? "),
                      isResendDisabled
                          ? Text(formatTime(timer))
                          : GestureDetector(
                              onTap: resendOtp,
                              child: const Text("Resend", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                            ),
                    ],
                  ),
                  const Spacer(),
                  // 4. Added Loading Spinner
                  // authState.verifyOtpLoading 
                  //   ? const CircularProgressIndicator()
                  //   : ElevatedButton(
                  //       onPressed: () => handleSubmitOtp(otpController.text),
                  //       style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  //       child: const Text("Submit"),
                  //     ),
                ] else ...[
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      errorText: error.isEmpty ? null : error,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("By signing up, you agree to Terms & Privacy Policy", style: TextStyle(fontSize: 12)),
                  const Spacer(),
                  // 5. Added Loading Spinner for Login
                  // authState.loginLoading 
                  //   ? const CircularProgressIndicator()
                  //   : CustomButtonWithImage(
                  //       text: "Login",
                  //       onPressed: handleLogin,
                  //       rightIcon: Image.asset(AppImages.arrow, height: 15, width: 15),
                  //     ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}