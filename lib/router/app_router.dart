import 'package:flutter_application_1/router/aiastro_routes.dart';
import 'package:flutter_application_1/router/astrologer_routes.dart';
import 'package:flutter_application_1/router/bottom_tab.dart';
import 'package:flutter_application_1/router/profile_routes.dart';
import 'package:flutter_application_1/router/service_routes.dart';
import 'package:flutter_application_1/screens/home/view/home.dart';
import 'package:flutter_application_1/screens/login/view/login.dart';
import 'package:flutter_application_1/screens/pager_view/pager_view.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),

        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),

        GoRoute(
          path: '/pager',
          builder: (context, state) => const PagerView(),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return BottomNavShell(child: child);
          },
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const Home(),
            ),
            ...serviceRoutes,
            ...aiAstroRoutes,
            ...expertRoutes,
            ...profileRoutes,
          ],
        ),
      ],
    );
}