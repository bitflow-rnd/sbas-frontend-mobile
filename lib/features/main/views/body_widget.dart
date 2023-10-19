import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/bitflow_theme.dart';
import '../../../constants/palette.dart';

Widget body(String content) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 20.w,
    ),
    child: Text(
      content,
      maxLines: 9999,
      style: CTS(fontSize: 12, color: Palette.greyText_80),
    ),
  );
}