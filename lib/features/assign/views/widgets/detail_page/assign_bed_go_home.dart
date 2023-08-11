import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';

class AssignBedGoHome extends StatefulWidget {
  AssignBedGoHome({
    super.key,
    required this.patient,
  });
  Patient patient;
  @override
  State<AssignBedGoHome> createState() => _AssignBedGoHomeState();
}

class _AssignBedGoHomeState extends State<AssignBedGoHome> {
  int selectedRadio = 0;

  List<String> list = ['의료기관명', '병실', '진료과', '병실', '담당의', '연락처', '메시지'];
  List<String> hintList = [
    '칠곡경북대병원',
    '병실번호',
    '진료과 입력',
    '병실번호 입력',
    '담당의 이름',
    '의료진 연락처 입력',
    '입원/퇴원/회송 사유 입력'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          title: Text(
            "입·퇴원 처리",
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
          automaticallyImplyLeading: false,
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
                        _getTitle("입·퇴원 상태", true),
                        Gaps.v16,
                        rowSelectButton(['병원', '자택', '기타']),
                        Gaps.v28,
                        for (var i = 0; i < list.length; i++)
                          Column(
                            children: [
                              _getTitle(list[i], false),
                              Gaps.v16,
                              _getTextInputField(
                                  hint: hintList[i], isFixed: i == 0),
                              Gaps.v28,
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),

              Common.bottomer(
                rBtnText: "요청 완료",
                lBtnText: "이전",
                lBtnFunc: () {
                  Navigator.pop(context);
                },
                rBtnFunc: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
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

  Widget rowSelectButton(
    List<String> list,
  ) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffe4e4e4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              for (var i in list)
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(i,
                            style: CTS.bold(
                                fontSize: 11, color: Colors.transparent)),
                      ),
                      Gaps.h1,
                    ],
                  ),
                ),
            ],
          ),
        ),
        Row(
          children: [
            for (var i in list)
              Expanded(
                child: InkWell(
                  onTap: () {
                    print(i);
                    setState(() {
                      selectedRadio = list.indexOf(i);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: list[selectedRadio] == i
                                  ? const Color(0xff538ef5)
                                  : Colors.transparent,
                              borderRadius: list[selectedRadio] == i
                                  ? BorderRadius.circular(6)
                                  : null),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(i,
                              style: CTS.bold(
                                fontSize: 11,
                                color: list[selectedRadio] == i
                                    ? Palette.white
                                    : Palette.greyText_60,
                              )),
                        ),
                      ),
                      i != list.last
                          ? Container(
                              height: 12,
                              width: 1,
                              decoration: BoxDecoration(
                                color: const Color(0xff676a7a).withOpacity(0.2),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
