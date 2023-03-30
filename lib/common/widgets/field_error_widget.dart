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
          bottom: 24,
        ),
        child: Text(
          field.errorText!,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 13,
            color: Colors.red[700],
            height: 0.5,
          ),
        ),
      );
}
