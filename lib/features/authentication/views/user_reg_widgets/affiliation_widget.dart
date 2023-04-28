import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/palette.dart';

class Affiliation<T> extends ConsumerWidget {
  const Affiliation({
    required this.onChanged,
    required this.title,
    super.key,
    required this.index,
    required this.selectedIndex,
  });
  final String title;
  final T index, selectedIndex;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
        borderRadius: BorderRadius.circular(
          24,
        ),
        onTap: () => onChanged(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: index == selectedIndex ? Colors.transparent : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(
              30,
            ),
            color: index == selectedIndex ? Palette.mainColor : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: index == selectedIndex ? Colors.white : Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      );
}
