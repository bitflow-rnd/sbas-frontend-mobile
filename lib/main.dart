import 'package:flutter/material.dart';
import 'package:sbas/config/bitflow_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스마트병상배정시스템',
      theme: Bitflow.getTheme(),
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
