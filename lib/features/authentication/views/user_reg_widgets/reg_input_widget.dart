import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';
import 'package:sbas/features/authentication/views/user_reg_req_screen_v2.dart';
import 'package:sbas/util.dart';
import 'package:telephony/telephony.dart';

class RegInput extends ConsumerStatefulWidget {
  const RegInput(
      {super.key,
      required this.hintText,
      required this.title,
      required this.isRequired,
      required this.maxLength,
      required this.keyboardType,
      this.validator,
      required this.onSaved,
      required this.regExp,
      required this.text,
      this.pnumVerify});
  final String hintText, title, regExp;
  final String? text;
  final bool isRequired;
  final int maxLength;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? pnumVerify;

  @override
  ConsumerState<RegInput> createState() => _RegInputState();
}

class _RegInputState extends ConsumerState<RegInput> {
  bool isAuthCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title != "")
          Row(
            children: [
              Text(
                widget.title,
                style: CTS.medium(
                  color: Palette.greyText_80,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                widget.isRequired ? '(필수)' : '',
                style: CTS.medium(
                  fontSize: 13.sp,
                  color: Palette.mainColor,
                ),
              ),
            ],
          ),
        Gaps.v4,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormField(
                builder: (field) => TextFormField(
                  style: CTS(color: Palette.black, fontSize: 13.sp),
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
                    counterText: "",
                    enabledBorder: _outlineInputBorder,
                    focusedBorder: _outlineInputBorder,
                    errorBorder: _outlineInputBorder,
                    focusedErrorBorder: _outlineInputErrBorder,
                    hintText: widget.hintText,
                    hintStyle: CTS.regular(
                      fontSize: 13.sp,
                      color: Palette.greyText_60,
                    ),
                    contentPadding: EdgeInsets.only(bottom: 0.0, top: 15.h),
                    prefix: Padding(
                        padding: EdgeInsets.only(
                      left: 20.0.w,
                    )),
                  ),
                  autovalidateMode: AutovalidateMode.always,

                  // onEditingComplete: () async {
                  //   {
                  //     if (widget.hintText == "인증번호 6자리 입력") {
                  //       final res = await ref.read(signUpProvider.notifier).confirm(editingController.text);
                  //       ref.watch(isPhoneAuthSuccess.notifier).state = res["message"] == "SUCCESS";
                  //     }
                  //   }
                  // }
                ),
              ),
            ),
            if (widget.title == "휴대폰번호")
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 36.w,
                    ),
                    backgroundColor: Palette.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    await ref.read(userRegReqProvider).sendAuthMessage(editingController.text);
                    ref.read(regUserProvider).telno = editingController.text;
                    showToast("메세지 전송 완료");
                  },
                  child: Text(
                    "전송",
                    style: CTS(
                      color: Palette.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            if (widget.title == "")
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 36.w,
                        ),
                        backgroundColor: Palette.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () async {
                        if (editingController.text != "" && editingController.text.length == 6) {
                          final res = await ref.read(signUpProvider.notifier).confirm(editingController.text);
                          ref.watch(isPhoneAuthSuccess.notifier).state = res["message"] == "SUCCESS";
                          isAuthCompleted = true;
                          showToast("인증 완료");
                        }
                      },
                      child: Text(
                        "인증",
                        style: CTS(
                          color: Palette.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  if (!isAuthCompleted)
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Container(
                        padding: EdgeInsets.only(top: 15.h, right: 12.w),
                        child: Text(
                          "유효시간 02:59",
                          style: CTS(
                            color: Palette.red,
                            fontSize: 11,
                          ),
                        ).c,
                      ),
                    ),
                ],
              ),
          ],
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
          // initMobileNumberState();
        }
      });
      // initMobileNumberState();
    }
    if (TextInputType.number == widget.keyboardType && widget.maxLength == 6) {
      initPlatformState();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
        onNewMessage: (message) {
          if (message.body != null && message.body!.isNotEmpty) {
            editingController.text = message.body!.splitMapJoin(
              RegExp(r'\d{6}'),
              onMatch: (m) => '${m[0]}',
              onNonMatch: (n) => '',
            );
            setState(
              () {
                ref.read(regUserProvider).pushKey = '';
                isReadOnly = true;
              },
            );
          }
        },
        listenInBackground: false,
      );
    }

    if (!mounted) return;
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;

      return;
    }
    try {
      final mobileNumber = await MobileNumber.mobileNumber ?? '';
      final simCard = await MobileNumber.getSimCards ?? [];

      for (var element in simCard) {
        if (mobileNumber.endsWith(element.number ?? ' ')) {
          final prefix = element.countryPhonePrefix;

          if (prefix != null && prefix.isNotEmpty) {
            final phoneNumber = element.number?.replaceAll('+$prefix', '0');

            if (phoneNumber != null && phoneNumber.isNotEmpty) {
              editingController.text = phoneNumber;

              if (mounted) {
                setState(
                  () => isReadOnly = true,
                );
                await ref.read(userRegReqProvider).sendAuthMessage(phoneNumber);
              }
            }
          }
        }
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }

  InputBorder get _outlineInputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      );
  InputBorder get _outlineInputErrBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Palette.red,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      );
  late final editingController = TextEditingController(
    text: widget.text,
  );
  final telephony = Telephony.instance;

  bool isReadOnly = false;
}
