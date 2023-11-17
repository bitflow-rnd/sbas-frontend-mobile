import 'package:flutter/material.dart';

class FieldErrorText extends StatelessWidget {
  const FieldErrorText({
    super.key,
    required this.field,
  });
  final FormFieldState<Object?> field;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Text(
          field.errorText!,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 12,
            color: Colors.red[700],
            height: 0.5,
          ),
        ),
      );
}
