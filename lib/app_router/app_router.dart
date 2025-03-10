import 'package:flutter_training/app_router/route_strings.dart';
import 'package:flutter_training/screens/detail_screen.dart';
import 'package:go_router/go_router.dart';
import '../screens/home.dart';

class AppRoutes {

  static GoRouter router = GoRouter(
    initialLocation: AppRouteConstants.home,
    routes: [
      GoRoute(
        path: AppRouteConstants.home,
        builder: (context, state) => Home(),
      ),
      GoRoute(
        path: AppRouteConstants.detail,
        builder: (context, state) => DetailScreen(),
      ),
    ],
  );
}
