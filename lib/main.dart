import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/providers/loading_provider.dart';
import 'package:sbas/common/widgets/observer_widget.dart';
import 'package:sbas/firebase_options.dart';
import 'package:sbas/router.dart';
import 'package:sbas/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/widgets/loading_spinner.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async =>
    onReceiveCloudMessage(message);
final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);
late AndroidInitializationSettings initialzationSettingsAndroid;
late DarwinInitializationSettings initialzationSettingsIOS;

_showLocalMessage(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/launcher_icon',
        ),
      ),
    );
  }
}

Future main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);
  // android 초기화
  initialzationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/launcher_icon');

  final FirebaseMessaging fbMessaging = FirebaseMessaging.instance;
  await fbMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final storagePermission = await Permission.storage.status;
  if (!storagePermission.isGranted) {
    await Permission.storage.request();
  }
  final cameraPermission = await Permission.camera.status;
  if (!cameraPermission.isGranted) {
    await Permission.camera.request();
  }

  // ios - 소리, 뱃지, 알림창 허용 여부.
  initialzationSettingsIOS = const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  await _flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: DarwinInitializationSettings()),
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      //포어그라운드 클릭시 이벤트 처리하고 싶을 때 사용
      // _checkMessage(foregroundMessage);
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((data) => _showLocalMessage(data));

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
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _) {
        return MaterialApp.router(
          routerConfig: ref.watch(routerProvider),
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,
          title: '스마트병상배정시스템',
          theme: Bitflow.getTheme(),
          darkTheme: Bitflow.getDarkTheme(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KR'),
            Locale('en', 'US'),
          ],
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                if (ref.watch(loadingProvider))
                  const Stack(
                    children: [
                      ModalBarrier(
                        dismissible: false,
                        color: Colors.black54,
                      ),
                      LoadingSpinner(), // 로딩 스피너 추가
                    ],
                  )
              ],
            );
          },
        );
      },
    );
  }
}
