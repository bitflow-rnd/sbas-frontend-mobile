import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';

class SearchTextFormWidget extends StatelessWidget {
  final String hintText;
  //Todo
  //  function 추가

  const SearchTextFormWidget({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_rounded,
          ),
        ),
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: CTS.bold(
          color: Colors.grey,
          fontSize: 11,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(7.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(7.r),
        ),
      ),
    );
  }

}