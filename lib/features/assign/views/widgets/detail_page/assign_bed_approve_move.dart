import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';

class AssignBedApproveMoveScreen extends StatefulWidget {
  AssignBedApproveMoveScreen({
    super.key,
    required this.patient,
  });
  Patient patient;
  @override
  State<AssignBedApproveMoveScreen> createState() =>
      _AssignBedApproveMoveScreenState();
}

class _AssignBedApproveMoveScreenState
    extends State<AssignBedApproveMoveScreen> {
  List<String> list = ['관할 구급대', '연락처', '탑승대원 및 의료진', '배차정보', '메시지'];
  List<String> hintList = ['', '연락처 입력', '', '차량번호 입력', '메시지 입력'];
  // 이부분 의료기관명 readonly 로 들어갈부분.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          title: Text(
            "이송 처리",
            style: CTS.medium(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Palette.greyText,
                weight: 24.h,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          elevation: 0.5,
          centerTitle: true,
          backgroundColor: Colors.white,
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
              _header(widget.patient.ptNm ?? '',
                  "(${widget.patient.getSex()} / ${widget.patient.getAge()}세 / 대구 북구 / 010-8833-1234)"), //pnum 등 분리필요
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
                        _getTitle(list[0], true),
                        Gaps.v16,
                        Container(child: firstRow()),
                        Gaps.v28,
                        Row(
                          children: [
                            _getTitle('연락처', true),
                            Gaps.h16,
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(left: 12.w),
                                    child:
                                        _getTextInputField(hint: hintList[1]))),
                          ],
                        ),
                        Gaps.v28,
                        _getTitle(list[2], false),
                        Gaps.v8,
                        _thirdRow(),
                        Gaps.v8,
                        _thirdRow(),
                        Gaps.v8,
                        _thirdRow(),
                        Gaps.v28,
                        Row(
                          children: [
                            _getTitle(list[3], false),
                            Spacer(),
                            carNumTag("54더1980"),
                            carNumTag("143호1927"),
                          ],
                        ),
                        Gaps.v12,
                        _getTextInputField(hint: hintList[3]),
                        Gaps.v28,
                        _getTitle(list[4], false),
                        Gaps.v16,
                        _getTextInputField(hint: hintList[4], maxLines: 6),
                        Gaps.v28,
                      ],
                    ),
                  ),
                ),
              ),

              Common.bottomer(
                rBtnText: "처리 완료",
                isOneBtn: true,
                lBtnFunc: () {},
                rBtnFunc: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }

  Widget carNumTag(String num) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        border: Border.all(
          color: Palette.greyText_20,
          width: 1,
        ),
      ),
      child: Text(
        num,
        style: CTS(fontSize: 13, color: Palette.greyText_80),
      ),
    );
  }

  Row _thirdRow() {
    List<String> dropdownList = ['대원선택', '최근3개월', '최근1년'];
    String selectedDropdown = '대원선택';
    return Row(
      children: [
        Expanded(child: dropdownButton(dropdownList, selectedDropdown)),
        Gaps.h12,
        Expanded(child: _getTextInputField(hint: '직급')),
        Gaps.h12,
        Expanded(child: _getTextInputField(hint: '이름'))
      ],
    );
  }

  Widget _getTextInputField(
      {bool isFixed = false,
      required String hint,
      TextInputType type = TextInputType.text,
      int? maxLines,
      List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      decoration: !isFixed
          ? Common.getInputDecoration(hint)
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
            isRequired ? '(필수)' : '(선택)',
            style: CTS.medium(
              fontSize: 13,
              color: !isRequired ? Colors.grey.shade600 : Palette.mainColor,
            ),
          ),
        ],
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
                        color: Color(0xff333333),
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

  Widget dropdownButton(List<String> dlist, String sel) {
    return SizedBox(
      height: 48.h,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(4.r),
        decoration: Common.getInputDecoration(""),
        value: sel,
        items: dlist.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: CTS(fontSize: 10, color: Palette.black),
            ),
          );
        }).toList(),
        onChanged: (dynamic value) {
          // setState(() {
          //   selectedDropdown = value;
          // });
        },
      ),
    );
  }

  Widget firstRow() {
    List<String> dropdownList = ['대구광역시', '최근3개월', '최근1년'];

    String selectedDropdown = '대구광역시';

    return Row(children: [
      Expanded(child: dropdownButton(dropdownList, selectedDropdown)),
      Gaps.h12,
      Expanded(child: dropdownButton(dropdownList, selectedDropdown)),
      Gaps.h12,
      Expanded(child: _getTextInputField(hint: "직접 입력"))
    ]);
  }
}
