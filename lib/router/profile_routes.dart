import 'package:flutter_application_1/screens/profile/view/my_details.dart';
import 'package:flutter_application_1/screens/profile/view/my_kundli.dart';
import 'package:flutter_application_1/screens/profile/view/order_history.dart';
import 'package:flutter_application_1/screens/profile/view/profile.dart';
import 'package:flutter_application_1/screens/profile/view/saved_profile.dart';
import 'package:flutter_application_1/screens/profile/view/term_condition.dart';
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
      GoRoute(
        path: '/my-kundli',
        builder: (context, state) => const MyKundli(),
      ),
      GoRoute(
        path: '/order-history',
        builder: (context, state) => const OrderHistory(),
      ),
      GoRoute(
        path: '/my-details',
        builder: (context, state) => const MyDetails(),
      ),
      GoRoute(
        path: '/saved-profile',
        builder: (context, state) => const SavedProfile(),
      ),
      GoRoute(
        path: '/terms-condition',
        builder: (context, state) => const TermCondition(),
      ),
    ],
  ),
];
