import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/palette.dart';

import '../common/bitflow_theme.dart';

class Common {
  static showModal(BuildContext context, Widget modal) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        barrierColor: Palette.modalBackground,
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return modal;
        },
        transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static Widget commonModal({
    required BuildContext context,
    required String mainText,
    Color button1Color = Palette.greyText,
    Color button2Color = Palette.mainColor,
    String button1Text = '취소',
    String button2Text = '확인',
    Color button1TextColor = Palette.greyText,
    Color button2TextColor = Palette.white,
    Route? button1Route,
    Route? button2Route,
    void Function()? button1Function,
    void Function()? button2Function,
    Widget? imageWidget,
    double? imageHeight,
  }) {
    return IntrinsicWidth(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        backgroundColor: Palette.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.r),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                if (imageWidget != null)
                  Container(
                    margin: EdgeInsets.only(top: 24.h),
                    height: imageHeight ?? 80.h,
                    child: Center(child: imageWidget),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.r, bottom: 24.r),
                        child: Text(
                          mainText,
                          textAlign: TextAlign.center,
                          style: CTS.bold(color: Palette.black, fontSize: 14, height: 1.5),
                        ).c,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.r),
                  child: Row(
                    children: [
                      button1Function != null
                          ? Expanded(
                              //left button(이전)
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.r),
                                child: Material(
                                  color: button1Color,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Palette.greyText_20,
                                        width: 1.w,
                                      ),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        button1Function == null ? Navigator.pop(context, false) : button1Function();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 9.r),
                                        child: Text(
                                          button1Text,
                                          style: CTS(color: button1TextColor, fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ).c,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      if (button1Function != null) SizedBox(width: 12.w),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: Container(
                            decoration: BoxDecoration(
                              color: button2Color,
                              border: Border.all(
                                color: button2Color,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Material(
                              color: button2Color,
                              child: InkWell(
                                onTap: () {
                                  button2Function == null ? Navigator.pop(context, true) : button2Function();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 9.r),
                                  child: Text(
                                    button2Text,
                                    style: CTS(color: button2TextColor, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ).c,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}