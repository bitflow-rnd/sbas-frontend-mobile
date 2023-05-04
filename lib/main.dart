import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/observer_widget.dart';
import 'package:sbas/firebase_options.dart';
import 'package:sbas/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async =>
    onReceiveCloudMessage(message);

Future main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(onReceiveCloudMessage);

  await dotenv.load(
    fileName: '.env',
  );
  WidgetsBinding.instance.addObserver(
    SbasObserver(),
  );
  prefs = await SharedPreferences.getInstance();

  runApp(
    const ProviderScope(
      observers: [],
      overrides: [],
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => ScreenUtilInit(
        designSize: const Size(
          360,
          690,
        ),
        builder: (context, _) => MaterialApp.router(
          routerConfig: ref.watch(routerProvider),
          debugShowCheckedModeBanner: false,
          title: '스마트병상배정시스템',
          theme: Bitflow.getTheme(),
          darkTheme: Bitflow.getDarkTheme(),
        ),
      );
}
