import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbas/common/global_variable.dart';
import 'package:sbas/util.dart';

class SbasObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeMetrics() {
    final window = WidgetsBinding.instance.window;

    if (window.physicalSize.width > window.physicalSize.height) {
    } else {}
    if (window.viewInsets.bottom > 0) {}
  }
}

void onReceiveCloudMessage(RemoteMessage message) {
  // show alert messages
  final context = CustomGlobalVariable.scaffoldMessengerKey.currentContext!;

  showNotiSnack(
    context,
    message.notification?.title ?? "",
  );
  if (kDebugMode) {
    print(message.toMap());
  }
}
