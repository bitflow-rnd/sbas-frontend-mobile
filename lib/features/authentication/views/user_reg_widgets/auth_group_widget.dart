import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class AuthorizationGroup<T> extends ConsumerWidget {
  const AuthorizationGroup({
    super.key,
    required this.selectedImage,
    required this.disabledImage,
    required this.title,
    required this.subTitle,
    required this.index,
    required this.selectedIndex,
    required this.onChanged,
  });
  final String selectedImage, disabledImage, title, subTitle;
  final T index, selectedIndex;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
        onTap: () => onChanged(index),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12,
            ),
            border: Border.all(
              color: index == selectedIndex ? Palette.mainColor : Colors.grey.shade400,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                index == selectedIndex ? selectedImage : disabledImage,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              Gaps.v4,
              Text(
                title,
                style: TextStyle(
                  color: index == selectedIndex ? Palette.mainColor : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v4,
              Text(
                subTitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
}
