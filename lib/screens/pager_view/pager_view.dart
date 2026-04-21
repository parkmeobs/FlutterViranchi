import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/constants/app_images.dart';
import 'package:flutter_application_1/components/animated_logo.dart';
import 'package:go_router/go_router.dart';

class PagerView extends StatefulWidget {
  const PagerView({super.key});

  @override
  State<PagerView> createState() => _PagerViewState();
}

class _PagerViewState extends State<PagerView>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  int index = 0;

  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> pages = [
    {
      "image": AppImages.splash1,
      "title": "Welcome",
      "desc": "Welcome Sub Text",
    },
    {
      "image": AppImages.splash2,
      "title": "Personalized Kundli",
      "desc": "Personalized Kundli Sub Text",
    },
    {
      "image": AppImages.splash3,
      "title": "Match Making",
      "desc": "Matchmaking Sub Text",
    },
  ];

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> handleNext() async {
    if (index < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);

      if (!mounted) return;
      context.go('/login');
    }
  }

  Future<void> skip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    if (!mounted) return;

    context.go('/login'); // ✅ FIXED
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9E5),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔝 TOP SECTION (Skip Button)
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: skip,
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// 📄 BOTTOM SECTION (Pager)
            Expanded(
              flex: 8,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    /// PageView
                    Expanded(
                      child: PageView.builder(
                        controller: _controller,
                        onPageChanged: (i) {
                          setState(() => index = i);

                          /// restart animation on page change
                          _animController.reset();
                          _animController.forward();
                        },
                        itemCount: pages.length,
                        itemBuilder: (context, i) {
                          final item = pages[i];

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item["title"],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Text(
                                  item["desc"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Image.asset(
                                item["image"],
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    /// 🔵 DOT INDICATORS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: index == i ? 12 : 8,
                          height: index == i ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == i
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔘 BUTTON
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: handleNext,
                        child: Text(
                          index == pages.length - 1 ? "Get Started" : "Next",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
