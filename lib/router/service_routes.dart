import 'package:flutter_application_1/screens/service/dasha/View/dasha.dart';
import 'package:flutter_application_1/screens/service/view/service.dart';
import 'package:go_router/go_router.dart';



final List<GoRoute> serviceRoutes = [
  GoRoute(
    path: '/service',
    builder: (context, state) => const Service(),
    routes: [
      GoRoute(
        path: 'dasha',
        builder: (context, state) => const Dasha(),
      ),
   
    ],
  ),
];