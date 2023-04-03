import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/common/widgets/nav_tab.dart';
import 'package:sbas/features/assign/views/screens/assign_bed_screen.dart';
import 'package:sbas/features/messages/views/screens/direct_message_screen.dart';
import 'package:sbas/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:sbas/features/lookup/views/patient_lookup.dart';

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
  final List<String> _tabs = [
    'home',
    'assign',
    'lookup',
    'message',
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      if (kDebugMode) {
        print(index);
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const DashboardScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const AssignBedScreen(
              automaticallyImplyLeading: true,
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const PatientLookupScreen(
              automaticallyImplyLeading: true,
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const DirectMessageScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: '홈',
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: '병상배정',
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AssignBedScreen(
                      automaticallyImplyLeading: false,
                    ),
                  ),
                ),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: '환자조회',
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientLookupScreen(
                      automaticallyImplyLeading: false,
                    ),
                  ),
                ),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: '연락처/DM',
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.message,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
