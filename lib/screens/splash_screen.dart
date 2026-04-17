import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/animated_logo.dart';
import 'package:flutter_application_1/constants/app_images.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    // ✅ 1. Track Event (like PostHog / AppsFlyer)


    // ✅ 4. Simulate Redux Rehydration (get token)
    final token = "";

    // ✅ 5. Delay (Splash duration)
    await Future.delayed(const Duration(seconds: 2));

    // ✅ 6. Navigate

    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
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
              child: Image.asset(
                AppImages.appBackground,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// ✅ Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedLogo(
                  logo: 90,
                  inner: 218,
                  outer: 240,
                ),

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