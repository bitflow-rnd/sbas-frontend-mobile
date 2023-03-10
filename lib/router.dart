import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/screens/home_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          /*
            TODO ref.read(notificationsProvider(context));
          */
          return child;
        },
        routes: [
          GoRoute(
            name: HomeScreen.routeName,
            path: HomeScreen.routeUrl,
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      )
    ],
  ),
);
