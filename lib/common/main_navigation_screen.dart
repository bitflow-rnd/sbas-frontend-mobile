import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/common/widgets/nav_tab.dart';
import 'package:sbas/features/assign/views/assign_bed_screen.dart';
import 'package:sbas/features/dashboard/views/dashboard_screen.dart';
import 'package:sbas/features/lookup/views/patient_lookup_screen.dart';
import 'package:sbas/features/messages/views/direct_message_screen.dart';

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
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
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
                path: 'home',
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: '병상배정',
                isSelected: _selectedIndex == 1,
                path: 'bed',
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
                path: 'lookup',
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
                path: 'message',
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
