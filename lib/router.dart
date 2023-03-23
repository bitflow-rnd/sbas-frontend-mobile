import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/common/main_navigation_screen.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/authentication/views/login_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/home',
    redirect: (context, state) async {
      final isLoggedIn = await ref.read(authRepo).isLoggedIn;

      if (!isLoggedIn) {
        return LogInScreen.routeUrl;
      }

      return null;
    },
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
            name: LogInScreen.routeName,
            path: LogInScreen.routeUrl,
            builder: (context, state) => const LogInScreen(),
          ),
          GoRoute(
            name: MainNavigationScreen.routeName,
            path: '/:tab(home|assign|lookup|message)',
            builder: (context, state) {
              final tab = state.params['tab']!;
              return MainNavigationScreen(
                tab: tab,
              );
            },
          ),
        ],
      )
    ],
  ),
);
