import 'package:flutter_application_1/screens/profile/view/profile.dart';
import 'package:go_router/go_router.dart';



final List<GoRoute> profileRoutes = [
  GoRoute(
    path: '/profile',
    builder: (context, state) => const Profile(),
    routes: [
      // GoRoute(
      //   path: 'complete',
      //   builder: (context, state) => const CompleteProfile(),
      // ),
      // GoRoute(
      //   path: 'kundali',
      //   builder: (context, state) => const MyKundali(),
      // ),
    ],
  ),
];