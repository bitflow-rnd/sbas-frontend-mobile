import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/bitflow_theme.dart';
import '../../../constants/palette.dart';

Widget header(String title) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 20.w,
      vertical: 12.h,
    ),
    child: Row(
      children: [
        Text(
          title,
          style: CTS.bold(fontSize: 14, color: Palette.black),
        ),
      ],
    ),
  );
}