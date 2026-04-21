import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/riverpod/user_provider.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final userLanguage = ref.watch(userProvider).userLanguage;

    void handleLanguage(String lang) {
      ref.read(userProvider.notifier).setUserLanguage(lang);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 EN Button
            GestureDetector(
              onTap: () => handleLanguage('en'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: userLanguage == 'en'
                      ? Colors.black
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'EN',
                  style: TextStyle(
                    color: userLanguage == 'en' ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// 🔹 HI Button
            GestureDetector(
              onTap: () => handleLanguage('hi'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: userLanguage == 'hi'
                      ? Colors.black
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'हि',
                  style: TextStyle(
                    color: userLanguage == 'hi' ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
