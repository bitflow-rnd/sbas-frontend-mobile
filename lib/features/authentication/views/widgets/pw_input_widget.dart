import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbas/constants/gaps.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    required this.label,
  });
  final String label;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        Gaps.v6,
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(
                r'[0-9|a-z|~!@#$%^&*()_-]',
              ),
            ),
            FilteringTextInputFormatter.singleLineFormatter
          ],
          maxLength: 15,
          controller: fieldPassword,
          obscureText: !isVisibility,
          decoration: InputDecoration(
            fillColor: Colors.grey[250],
            filled: true,
            suffixIcon: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      fieldPassword.clear();
                    }),
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        setState(() => isVisibility = !isVisibility),
                    icon: Icon(
                      isVisibility ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ],
              ),
            ),
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
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  final fieldPassword = TextEditingController();

  bool isVisibility = false;
}
