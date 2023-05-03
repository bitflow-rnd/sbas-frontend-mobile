import 'package:flutter/material.dart';

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
