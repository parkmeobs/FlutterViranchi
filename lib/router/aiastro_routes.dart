import 'package:flutter_application_1/screens/aiastro/view/getstarted.dart';
import 'package:go_router/go_router.dart';


final List<GoRoute> aiAstroRoutes = [
  GoRoute(
    path: '/ai',
    builder: (context, state) => const Getstarted(),
    routes: [
      // GoRoute(
      //   path: 'chat',
      //   builder: (context, state) => const ChatScreen(),
      // ),
      // GoRoute(
      //   path: 'profiles',
      //   builder: (context, state) => const ProfileListingScreen(),
      // ),
    ],
  ),
];