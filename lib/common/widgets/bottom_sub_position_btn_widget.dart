import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomPositionedSubmitButton extends ConsumerWidget {
  const BottomPositionedSubmitButton({
    required this.function,
    required this.text,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
        onTap: function,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
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
      );
  final String text;
  final void Function() function;
}
