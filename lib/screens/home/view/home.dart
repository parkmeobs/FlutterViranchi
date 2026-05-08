import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/view/widgets/daily_horoscope.dart';
import 'package:flutter_application_1/screens/home/view/widgets/header.dart';
import 'package:flutter_application_1/riverpod/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {  bool isLoading = true;
  bool refreshing = false;

  bool showProfileModal = false;
  bool showAIModal = false;

  Timer? profileTimer;
  Timer? aiTimer;

  Map<String, dynamic>? userDetail;
  List<dynamic> transactionHistory = [];

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  /// 🔹 Equivalent of useEffect + API chaining
  // Future<void> fetchData() async {
  //   try {
  //     setState(() => isLoading = true);

  //     // 1️⃣ Get user detail
  //     userDetail = await getUserDetail();

  //     // 2️⃣ If DOB exists → fetch astrology data
  //     if (userDetail?['dob'] != null) {
  //       await getMoonSign();
  //       await getPlanetDetails();
  //     }

  //     // 3️⃣ Daily horoscope
  //     await getDailyHoroscope();

  //     // 4️⃣ Panchang
  //     await getPanchang();

  //     // 5️⃣ Transactions
  //     transactionHistory = await getTransactionHistory();

  //     handleProfileModal();
  //     handleAIModal();
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  /// 🔹 Pull to refresh
  Future<void> onRefresh() async {
    setState(() => refreshing = true);
    // await fetchData();
    setState(() => refreshing = false);
  }

  /// 🔹 Profile Modal Logic
  void handleProfileModal() {
    if (userDetail?['dob'] == null) {
      profileTimer?.cancel();

      profileTimer = Timer(const Duration(seconds: 3), () {
        setState(() => showProfileModal = true);
      });
    }
  }

  /// 🔹 AI Modal Logic
  void handleAIModal() {
    if (transactionHistory.isEmpty) return;

    final hasCredits = transactionHistory.any(
      (item) => (item['amount'] ?? 0) > 0,
    );

    if (!hasCredits) return;

    aiTimer?.cancel();

    aiTimer = Timer(const Duration(seconds: 10), () {
      setState(() => showAIModal = true);
    });
  }

  @override
  void dispose() {
    profileTimer?.cancel();
    aiTimer?.cancel();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  // final userState = ref.watch(userProvider);
  // final string = userState.strings;

  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 2),
              children: [
                // Header(string: string), // ✅ now correct

                if (userDetail?['dob'] != null)
                  const DailyHoroscope(),
              ],
            ),
          ),

          // if (isLoading)
          //   const Center(child: CircularProgressIndicator()),
        ],
      ),
    ),
  );
}
}
