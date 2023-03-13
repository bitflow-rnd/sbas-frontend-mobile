import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/common/main_navigation_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/home',
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
