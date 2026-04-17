import 'package:flutter_application_1/screens/expert/view/expert_listing.dart';
import 'package:go_router/go_router.dart';



final List<GoRoute> expertRoutes = [
  GoRoute(
    path: '/expert',
    builder: (context, state) => const ExpertListing(),
    routes: [
      // GoRoute(
      //   path: 'detail',
      //   builder: (context, state) => const AstrologerDetailScreen(),
      // ),
      // GoRoute(
      //   path: 'checkout',
      //   builder: (context, state) => const CheckoutScreen(),
      // ),
    ],
  ),
];