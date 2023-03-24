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
    this.validator,
    required this.onSaved,
    required this.regExp,
    required this.text,
  });
  final String hintText, title, regExp;
  final String? text;
  final bool isRequired;
  final int maxLength;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

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
              RegExp(widget.regExp),
            ),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          onSaved: widget.onSaved,
          maxLength: widget.maxLength,
          validator: widget.validator,
          controller: editingController,
          decoration: InputDecoration(
            enabledBorder: _outlineInputBorder,
            focusedBorder: _outlineInputBorder,
            errorBorder: _outlineInputBorder,
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
          autovalidateMode: AutovalidateMode.always,
        ),
        Gaps.v16,
      ],
    );
  }

  InputBorder get _outlineInputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      );

  late final editingController = TextEditingController(
    text: widget.text,
  );
}
