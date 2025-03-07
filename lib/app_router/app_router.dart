import 'package:flutter_training/app_router/route_strings.dart';
import 'package:flutter_training/screens/search_screen.dart';
import 'package:go_router/go_router.dart';
import '../screens/checkout_screen.dart';
import '../screens/home.dart';
import '../screens/profile_screen.dart';
import '../widgets/card_interior.dart';

class AppRoutes {

  static GoRouter router = GoRouter(
    initialLocation: AppRouteConstants.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Home(child: child);
        },
        routes: [
          GoRoute(
            path: AppRouteConstants.home,
            builder: (context, state) => CardInterior(),
          ),
          GoRoute(
            path: AppRouteConstants.search,
            builder: (context, state) => SearchScreen(),
          ),
          GoRoute(
            path: AppRouteConstants.checkout,
            builder: (context, state) => CheckoutScreen(),
          ),
          GoRoute(
            path: AppRouteConstants.profile,
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}