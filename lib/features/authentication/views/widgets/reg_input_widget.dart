import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbas/constants/gaps.dart';

class RegInput extends StatefulWidget {
  const RegInput({
    super.key,
    required this.hintText,
    required this.title,
    required this.isRequired,
    required this.maxLength,
    required this.keyboardType,
  });
  final String hintText, title;
  final bool isRequired;
  final int maxLength;
  final TextInputType keyboardType;

  @override
  State<RegInput> createState() => _RegInputState();
}

class _RegInputState extends State<RegInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
            Text(
              widget.isRequired ? '*' : '',
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
        Gaps.v4,
        TextFormField(
          keyboardType: widget.keyboardType,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[a-z|0-9]'),
            ),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          maxLength: widget.maxLength,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '아이디를 입력하세요.';
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey.shade300,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey.shade300,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 22,
            ),
          ),
        ),
      ],
    );
  }
}
