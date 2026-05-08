import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/animated_logo.dart';
import 'package:flutter_application_1/constants/app_images.dart';
import 'package:flutter_application_1/screens/login/viewmodal/loginviewmodal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    // final token = "";
    final token ="nnn";

    print("token in splash: $token");
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (token == null || token.isEmpty) {
      context.go('/login');
    } else {
      context.go('/home'); // or home screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// ✅ Background Image (like React Native ImageBackground)
          Positioned.fill(
            child: Opacity(
              opacity: 0.95,
              child: Image.asset(AppImages.appBackground, fit: BoxFit.cover),
            ),
          ),

          /// ✅ Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedLogo(logo: 90, inner: 218, outer: 240),

                const SizedBox(height: 20),

                /// Text + Image
                Column(
                  children: [
                    Image.asset(
                      AppImages.viranchiText,
                      height: 30,
                      width: 150,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 20),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Discover Yourself through Personalized Astrology",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0A1F44),
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
