import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbas/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );
  prefs = await SharedPreferences.getInstance();

  await dotenv.load(
    fileName: '.env',
  );
  runApp(
    const ProviderScope(
      observers: [],
      overrides: [],
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: '스마트병상배정시스템',
      /*
        TODO: remove this line if you are using a theme.

        themeMode: ThemeMode.system,
      */
      theme: Bitflow.getTheme(),
      darkTheme: Bitflow.getDarkTheme(),
    );
  }
}
