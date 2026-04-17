import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavShell extends StatelessWidget {
  final Widget child;

  const BottomNavShell({super.key, required this.child});

  int _index(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();

    if (loc.startsWith('/service')) return 1;
    if (loc.startsWith('/ai')) return 2;
    if (loc.startsWith('/expert')) return 3;
    if (loc.startsWith('/profile')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int i) {
    switch (i) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/service');
        break;
      case 2:
        context.go('/ai');
        break;
      case 3:
        context.go('/expert');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final index = _index(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => _onTap(context, i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.miscellaneous_services), label: "Service"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "AI"),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: "Expert"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}