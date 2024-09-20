import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/common/main_navigation_screen.dart';
import 'package:sbas/features/assign/views/assign_bed_screen.dart';
import 'package:sbas/features/authentication/blocs/user_detail_presenter.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/authentication/views/login_screen.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/patient/views/patient_list_screen.dart';
import 'package:sbas/util.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/home',
    redirect: (context, state) async {
      final isLoggedIn = await ref.read(authRepo).isLoggedIn;

      if (isLoggedIn) {
        final provider = V1Provider();

        authToken = {
          'Authorization': 'Bearer ${prefs.getString('auth_token')}}',
        };
        String? pushKey = await FirebaseMessaging.instance.getToken();
        print("FCM firebase pushKey : $pushKey");
        await provider.postAsync('admin/user/push-key', toJson({'id': prefs.getString('id'), 'pushKey': pushKey}));
        await ref.watch(userDetailProvider.notifier).getUserDetails(prefs.getString('id')!);
        ref.watch(talkRoomsProvider.notifier).updateUserId(prefs.getString('id')!);
      }
      FlutterNativeSplash.remove();

      return isLoggedIn ? null : LogInScreen.routeUrl;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            name: LogInScreen.routeName,
            path: LogInScreen.routeUrl,
            builder: (context, state) => const LogInScreen(),
          ),
          GoRoute(
            name: AssignBedScreen.routeName,
            path: AssignBedScreen.routeUrl,
            builder: (context, state) => const AssignBedScreen(
              automaticallyImplyLeading: false,
            ),
          ),
          GoRoute(
            name: PatientListScreen.routeName,
            path: PatientListScreen.routeUrl,
            builder: (context, state) => const PatientListScreen(),
          ),
          GoRoute(
            name: MainNavigationScreen.routeName,
            path: '/:tab(home|assign|lookup|message)',
            builder: (context, state) {
              final tab = state.pathParameters['tab']!;

              return MainNavigationScreen(tab: tab);
            },
          ),
        ],
      )
    ],
  ),
);
