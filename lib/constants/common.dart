import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

import '../common/bitflow_theme.dart';

class Common {
  static InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.r,
          ),
        ),
      );
  static InputDecoration get inputDecoration => InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        contentPadding: const EdgeInsets.all(0),
      );

  static InputDecoration getInputDecoration(String hintText) => InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
        hintText: hintText,
        hintStyle: CTS(
          fontSize: 13.sp,
          color: Colors.grey.shade400,
        ),
        contentPadding: hintText == ""
            ? EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              )
            : EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
      );

  static Widget bottomer({String lBtnText = '배정 불가', String rBtnText = "승인", required Function lBtnFunc, required Function rBtnFunc, bool isOneBtn = false}) {
    return Row(
      children: [
        !isOneBtn
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    lBtnFunc();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 11.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Palette.greyText_80,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      lBtnText,
                      style: CTS(
                        color: Palette.greyText_80,
                        fontSize: 16,
                      ),
                    ).c,
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: InkWell(
            onTap: () {
              rBtnFunc();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: const BoxDecoration(
                color: Palette.mainColor,
              ),
              child: Text(
                rBtnText,
                style: CTS(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ).c,
            ),
          ),
        ),
      ],
    );
  }

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

  static showBottomSheet({required BuildContext context, String header = '배정 승인', String hintText = '메시지 입력', String btnText = '승인'}) async {
    TextEditingController textEditingController = TextEditingController();
    final focusNode = FocusNode();

    // Call requestFocus() on the focus node when the bottom sheet is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) => focusNode.requestFocus());
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.r),
          ),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: Container(
                height: 400.h,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            header,
                            style: CTS.medium(
                              fontSize: 15,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              weight: 24.h,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextField(
                                focusNode: focusNode,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  hintText: hintText,
                                  enabledBorder: _outlineInputBorder,
                                  focusedBorder: _outlineInputBorder,
                                  errorBorder: _outlineInputBorder,
                                )),
                          ),
                          Gaps.h8,
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Text(
                                  btnText,
                                  style: CTS(color: Palette.white, fontSize: 13),
                                ),
                              ),
                              onPressed: () {
                                String text = textEditingController.text;
                                // Perform action with the entered text here
                                return Navigator.pop(context, text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static InputBorder get _outlineInputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      );
}
