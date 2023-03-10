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
      title: '스마트병정배정시스템',
      theme: BitflowTheme.get(),
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
