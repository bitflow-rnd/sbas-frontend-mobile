import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    required this.label,
    required this.hintText,
  });
  final String label;
  final String hintText;

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
          style: CTS.bold(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        Gaps.v6,
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[a-z|0-9|~!@#$%^&*()_-]'),
            ),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          maxLength: 15,
          controller: fieldPassword,
          obscureText: !isVisibility,
          validator: (value) {
            if (value == null || value.length < 9) {
              return '비밀번호를 8자 이상 입력하세요.';
            }
            return null;
          },
          onChanged: (value) => setState(() {
            // fieldPassword.clear();
          }),
          // onSaved: (newValue) => ls.formData['pw'] = newValue ?? '',
          decoration: InputDecoration(
            fillColor: Palette.white,
            filled: true,
            counterStyle: const TextStyle(
              height: double.minPositive,
            ),
            counterText: "",
            suffixIcon: SizedBox(
              width: 40.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // fieldPassword.text.isNotEmpty
                  //     ? IconButton(
                  //         padding: EdgeInsets.symmetric(horizontal: 2.w), // 패딩 설정
                  //         constraints: const BoxConstraints(),
                  //         splashRadius: 15.r,
                  //         onPressed: () => setState(() {
                  //           fieldPassword.clear();
                  //         }),
                  //         icon: Icon(
                  //           fieldPassword.text.isNotEmpty ? Icons.close_rounded : null,
                  //           color: Palette.greyText_30,
                  //         ),
                  //       )
                  //     : Container(),
                  IconButton(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w), // 패딩 설정
                    constraints: const BoxConstraints(),
                    splashRadius: 15.r,
                    onPressed: () => setState(() => isVisibility = !isVisibility),
                    icon: Icon(
                      isVisibility ? Icons.visibility : Icons.visibility_off,
                      color: Palette.greyText_30,
                    ),
                  ),
                ],
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Palette.greyText_30,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Bitflow.radius_4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Palette.greyText_30,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Bitflow.radius_4),
              ),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Palette.greyText_30,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.r),
          ),
        ),
        // TextFormField(
        //   keyboardType: TextInputType.visiblePassword,
        //   inputFormatters: [
        //     FilteringTextInputFormatter.allow(
        //       RegExp(
        //         r'[0-9|a-z|~!@#$%^&*()_-]',
        //       ),
        //     ),
        //     FilteringTextInputFormatter.singleLineFormatter
        //   ],
        //   maxLength: 15,
        //   controller: fieldPassword,
        //   obscureText: !isVisibility,
        //   decoration: InputDecoration(
        //     fillColor: Colors.grey[250],
        //     filled: true,
        //     suffixIcon: SizedBox(
        //       width: 150,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           IconButton(
        //             onPressed: () => setState(() {
        //               fieldPassword.clear();
        //             }),
        //             icon: const Icon(
        //               Icons.close_rounded,
        //             ),
        //           ),
        //           IconButton(
        //             onPressed: () => setState(() => isVisibility = !isVisibility),
        //             icon: Icon(
        //               isVisibility ? Icons.visibility : Icons.visibility_off,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     enabledBorder: const OutlineInputBorder(
        //       borderSide: BorderSide(
        //         style: BorderStyle.none,
        //       ),
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(6),
        //       ),
        //     ),
        //     focusedBorder: const OutlineInputBorder(
        //       borderSide: BorderSide(
        //         style: BorderStyle.none,
        //       ),
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(6),
        //       ),
        //     ),
        //     contentPadding: const EdgeInsets.all(16),
        //   ),
        // ),
      ],
    );
  }

  final fieldPassword = TextEditingController();

  bool isVisibility = false;
}
