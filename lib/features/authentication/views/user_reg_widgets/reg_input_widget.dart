import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/user_reg_req_bloc.dart';

class RegInput extends ConsumerStatefulWidget {
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
  ConsumerState<RegInput> createState() => _RegInputState();
}

class _RegInputState extends ConsumerState<RegInput> {
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
          readOnly: isReadOnly,
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

  @override
  void initState() {
    if (TextInputType.phone == widget.keyboardType) {
      MobileNumber.listenPhonePermission((isPermissionGranted) {
        if (isPermissionGranted) {
          initMobileNumberState();
        }
      });
      initMobileNumberState();
    }
    super.initState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;

      return;
    }
    try {
      final mobileNumber = await MobileNumber.mobileNumber ?? '';
      final simCard = await MobileNumber.getSimCards ?? [];

      setState(() {
        for (var element in simCard) {
          if (mobileNumber.endsWith(element.number ?? ' ')) {
            final prefix = element.countryPhonePrefix;

            if (prefix != null && prefix.isNotEmpty) {
              final phoneNumber = element.number?.replaceAll('+$prefix', '0');

              if (phoneNumber != null && phoneNumber.isNotEmpty) {
                ref.read(userRegProvider.notifier).state.telno = phoneNumber;
                editingController.text = phoneNumber;
                isReadOnly = true;
              }
            }
          }
        }
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
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
  bool isReadOnly = false;
}
