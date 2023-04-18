import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomPositionedSubmitButton extends ConsumerWidget {
  const BottomPositionedSubmitButton({
    required this.function,
    required this.text,
    this.color,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        color: Colors.blueAccent,
        child: InkWell(
          onTap: function,
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: color ?? Colors.blueAccent,
                borderRadius: BorderRadius.circular(
                  6,
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  final String text;
  final Color? color;
  final void Function() function;
}
