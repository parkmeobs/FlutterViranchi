import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      "image": "assets/images/splash1.png",
      "title": "Welcome",
      "desc": "Welcome Sub Text",
    },
    {
      "image": "assets/images/splash2.png",
      "title": "Personalized Kundli",
      "desc": "Personalized Kundli Sub Text",
    },
    {
      "image": "assets/images/splash3.png",
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
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    _animController.forward();
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

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> skip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9E5),
      body: Column(
        children: [
          // TOP SECTION
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: skip,
                      child: const Text("Skip"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BOTTOM SECTION (Pager)
          Expanded(
            flex: 7,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (i) {
                        setState(() => index = i);
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item["desc"],
                              textAlign: TextAlign.center,
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

                  // DOT INDICATORS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(4),
                        width: index == i ? 10 : 8,
                        height: index == i ? 10 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          color: index == i ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BUTTON
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: handleNext,
                      child: Text(index == pages.length - 1
                          ? "Get Started"
                          : "Next"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}