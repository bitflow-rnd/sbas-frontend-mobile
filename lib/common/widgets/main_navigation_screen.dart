import 'package:flutter/material.dart';
import 'package:sbas/screens/home_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = 'mainNavigation';

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: const [
          Offstage(
            offstage: false,
            child: HomeScreen(),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: const [
            Text(
              'Home',
            )
          ],
        ),
      ),
    );
  }
}
