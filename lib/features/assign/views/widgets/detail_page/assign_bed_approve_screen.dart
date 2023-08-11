import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';

class AssignBedApproveScreen extends StatefulWidget {
  const AssignBedApproveScreen({
    super.key,
    required this.patient,
  });
  final Patient patient;
  @override
  State<AssignBedApproveScreen> createState() => _AssignBedApproveScreenState();
}

class _AssignBedApproveScreenState extends State<AssignBedApproveScreen> {
  List<String> list = ['의료기관명', '병실', '진료과', '담당의', '연락처', '메시지'];
  List<String> hintList = ['칠곡경북대병원', '병실번호', '진료과 이름', '담당의 이름', '의료진 연락처 입력', '메시지 입력'];
  // 이부분 의료기관명 readonly 로 들어갈부분.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Container(
            child: Scaffold(
                backgroundColor: Palette.white,
                appBar: AppBar(
                  title: Text(
                    "병상 배정",
                    style: CTS.medium(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  elevation: 0.5,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: const BackButton(
                    color: Colors.black,
                  ),
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    children: [
                      _header(widget.patient.ptNm ?? '', "(${widget.patient.getSex()} / ${widget.patient.getAge()}세 / 대구 북구 / 010-8833-1234)"), //pnum 등 분리필요
                      Divider(
                        color: Palette.greyText_20,
                        height: 1,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              children: [
                                Gaps.v20,
                                for (var i = 0; i < list.length; i++)
                                  Column(
                                    children: [
                                      _getTitle(list[i], false),
                                      Gaps.v16,
                                      _getTextInputField(hint: hintList[i], isFixed: i == 0),
                                      Gaps.v28,
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Common.bottomer(
                        rBtnText: "배정 승인",
                        isOneBtn: true,
                        lBtnFunc: () {},
                        rBtnFunc: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )),
          );
        });
  }

  Widget _getTextInputField(
      {bool isFixed = false, required String hint, TextInputType type = TextInputType.text, int? maxLines, List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      decoration: !isFixed
          ? getInputDecoration(hint)
          : InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.r),
                ),
              ),
            ),
      controller: TextEditingController(text: isFixed ? hint : ''),
      // onSaved: (newValue) => vm.setTextEditingController(i, newValue),
      // onChanged: (value) => vm.setTextEditingController(i, value),
      validator: (value) {
        return null;
      },
      readOnly: hint == '',

      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.always,
      keyboardType: type,
      maxLines: maxLines,
      // maxLength: maxLength,
    );
  }

  Widget _getTitle(String title, bool isRequired) => Row(
        children: [
          Text(
            title,
            style: CTS.medium(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          Text(
            title == '의료기관명' ? '' : '(필수)',
            style: CTS.medium(
              fontSize: 13,
              color: !isRequired ? Colors.grey.shade600 : Palette.mainColor,
            ),
          ),
        ],
      );

  InputDecoration getInputDecoration(String hintText) => InputDecoration(
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
        hintText: hintText,
        hintStyle: CTS.regular(
          fontSize: 13.sp,
          color: Palette.greyText_60,
        ),
        contentPadding: hintText == ""
            ? EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              )
            : const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 22,
              ),
      );

  InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      );
  InputDecoration get _inputDecoration => InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        contentPadding: const EdgeInsets.all(0),
      );
  Widget _header(String name, String detail) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 16.w,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/patient.png',
            height: 36.h,
            width: 36.h,
          ),
          Gaps.h8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: name,
                  style: CTS.bold(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: detail, //TODO :: MaxLines 관리및 디자인 협의필요 04.28하진우.
                      style: CTS(
                        color: const Color(0xff333333),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v4,
              const Text(
                '#중증#투석',
                style: TextStyle(
                  color: Palette.mainColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
