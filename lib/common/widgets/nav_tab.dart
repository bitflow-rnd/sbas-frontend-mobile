import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.path,
    required this.isSelected,
    required this.onTap,
    required this.selectedIndex,
  });
  @override
  Widget build(BuildContext context) => Expanded(
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
            color: Colors.transparent,
            child: AnimatedOpacity(
              duration: const Duration(
                milliseconds: 300,
              ),
              opacity: isSelected ? 1 : 0.6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/home/${path}_icon.png',
                    color: isSelected
                        ? const Color(0xFF000000)
                        : const Color(0xFF696969),
                    height: 22,
                  ),
                  Gaps.v5,
                  Text(
                    text,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF000000)
                          : const Color(0xFF696969),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  final String text, path;
  final bool isSelected;
  final Function onTap;
  final int selectedIndex;
}
