import 'package:flutter/material.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/common/bitflow_theme.dart';

class InputTextWidget extends StatelessWidget {
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String hintText;

  const InputTextWidget({super.key,
    required this.keyboardType,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        hintStyle: CTS(
              color: Palette.greyText_60,
              fontSize: 13,
            ),
        fillColor: Colors.grey[250],
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: Colors.red, // Use your color here
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Bitflow.defaultRadius),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: Colors.red, // Use your color here
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Bitflow.defaultRadius),
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}