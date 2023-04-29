import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/agency_detail_bloc.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';

class AssignReqDiseaseInfoInputScreen extends ConsumerWidget {
  AssignReqDiseaseInfoInputScreen({
    super.key,
  });
  final List<String> list = [
    '입원여부', //
    '담당보건소', //
    '코로나19증상 및 징후',
    '확진검사결과',
    '질병급',
    '발병일',
    '진단일',
    '신고일',
    '환자등분류',
    '비고',
    '요양기관명',
    '요양기관기호',
    '요양기관 주소', //
    '요양기관 전화번호',
    '진단의사 성명',
    '신고기관장 성명',
    '기타 진료정보 이미지 및 영상',
  ];
  final List<String> hintList = [
    '',
    '보건소명 직접입력',
    '코로나19증상 및 징후 입력',
    '확진검사결과 입력 예) 양성',
    '질병급 입력',
    'YYYY-MM-DD',
    'YYYY-MM-DD',
    'YYYY-MM-DD',
    '환자등분류 입력',
    'PCR등 검사방법 외 입력',
    '요양기관명 입력',
    '요양기관기호 입력',
    '상세주소 입력', //2 hint text
    '전화번호 입력',
    '진단의사 성명 입력',
    '신고기관장 성명  입력',
    '보건소명 직접입력',
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SingleChildScrollView(
          child: Column(
        children: [
          for (int i = 0; i < list.length; i++)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 18.h,
                  ),
                  child: Column(
                    children: [
                      _getTitle(list[i], true),
                      Gaps.v8,
                      _getInputField(
                        i,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      )),
    );
  }

  final oneList = ['입원', '외래', '재택', '기타'];
  int oneListSelected = 0;
  Widget Zero() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xffe4e4e4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              for (var i in oneList)
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                      child: Text(i, style: CTS.bold(fontSize: 11, color: Colors.transparent)),
                    ),
                    Gaps.h1,
                  ],
                )
            ],
          ),
        ),
        Row(
          children: [
            for (var i in oneList)
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: oneList[oneListSelected] == i ? Color(0xff538ef5) : Colors.transparent,
                        borderRadius: oneList[oneListSelected] == i ? BorderRadius.circular(6) : null),
                    padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                    child: Text(i,
                        style: CTS.bold(
                          fontSize: 11,
                          color: oneList[oneListSelected] == i ? Palette.white : Palette.greyText_60,
                        )),
                  ),
                  i != '기타'
                      ? Container(
                          height: 12,
                          width: 1,
                          decoration: BoxDecoration(
                            color: Color(0xff676a7a).withOpacity(0.2),
                          ),
                        )
                      : Container(),
                ],
              )
          ],
        ),
      ],
    );
  }

  Widget one() {
    List<String> dropdownList = ['최근1개월', '최근3개월', '최근1년'];

    String selectedDropdown = '최근1개월';

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48.h,
                child: DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(4.r),
                  decoration: getInputDecoration(""),
                  value: selectedDropdown,
                  items: dropdownList.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: CTS(fontSize: 11, color: Palette.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    // setState(() {
                    //   selectedDropdown = value;
                    // });
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 7.w),
                height: 48.h,
                width: 125.w,
                child: DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(4.r),
                  decoration: getInputDecoration(""),
                  value: selectedDropdown,
                  items: dropdownList.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: CTS(fontSize: 11, color: Palette.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    // setState(() {
                    //   selectedDropdown = value;
                    // });
                  },
                ),
              ),
            ),
          ],
        ),
        Gaps.v12,
        Row(
          children: [Expanded(child: _getTextInputField(hint: "보건소명 직접입력"))],
        )
      ],
    );
  }

  Widget twelve() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _getTextInputField(hint: "기본주소 입력")),
            InkWell(
              onTap: () {
                //주소검색 로직
              },
              child: Container(
                margin: EdgeInsets.only(left: 7.w),
                decoration: BoxDecoration(
                  color: Palette.mainColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
                child: Text(
                  "주소검색",
                  style: CTS(
                    fontSize: 13,
                    color: Palette.white,
                  ),
                ),
              ),
            )
          ],
        ),
        Gaps.v10,
        _getTextInputField(hint: "상세주소 입력"),
      ],
    );
  }

  Widget sixteen() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            border: Border.all(color: Palette.greyText_20),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Image.asset(
            'assets/auth_group/camera_location.png',
            width: 80.w,
            height: 80.h,
          ),
        )
      ],
    );
  }

  Widget _getInputField(int i) {
    if (i == 0) {
      return Zero();
    } else if (i == 1) {
      return one();
    } else if (i == 12) {
      return twelve();
    } else if (i == 16) {
      return sixteen();
    } else {
      return _getTextInputField(hint: hintList[i]);
    }
  }

  Widget _getTextInputField({required String hint, TextInputType type = TextInputType.text, int? maxLength, List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      decoration: getInputDecoration(hint),
      controller: TextEditingController(
          // text: vm.init(i, widget.report),
          ),
      // onSaved: (newValue) => vm.setTextEditingController(i, newValue),
      // onChanged: (value) => vm.setTextEditingController(i, value),
      validator: (value) {
        return null;
      },
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.always,
      keyboardType: type,
      maxLength: maxLength,
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
            title == '입원여부' ? '(필수)' : '(선택)',
            style: CTS.medium(
              fontSize: 13,
              color: title == '입원여부' ? Palette.mainColor : Colors.grey.shade600,
            ),
          ),
          if (title == '발병일') Spacer(),
          if (title == "발병일")
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Palette.mainColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/lookup/checked_icon.png",
                      height: 10.h,
                    ),
                    Gaps.h3,
                    Text(
                      '전체동일',
                      style: CTS.medium(fontSize: 13, color: Palette.mainColor),
                    ),
                  ],
                ),
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
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade400,
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
  // Widget _selectPublicHealthCenter(Iterable<InfoInstModel> center, FormFieldState<Object?> field) => SizedBox(

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
  InfoInstModel tempInfoInstModle = InfoInstModel(
    rgstUserId: "IMPORTER",
    rgstDttm: "2023-03-22T21:56:27.822790Z",
    updtUserId: "IMPORTER",
    updtDttm: "2023-03-22T21:56:27.822790Z",
    id: "FS00000001",
    instTypeCd: "ORGN0002",
    instNm: "수서",
    dstrCd1: "11",
    dstrCd2: "1168",
    chrgId: "서울특별시 강남구 ",
    chrgNm: null,
    chrgTelno: "02-445-9019",
    baseAddr: null,
    lat: null,
    lon: null,
    rmk: null,
    attcId: null,
  );
}

//  Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 // for(int j=0;j<patient.disease.length;j++)
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                       color: Palette.greyText_20,
//                                       width: 1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(13.5),
//                                   ),
//                                   child: Text(
//                                     "고지혈증",
//                                     // patient.disease[j].diseaseName,
//                                     style: CTS(fontSize: 13, color: Palette.greyText_80),
//                                     textAlign: TextAlign.end,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             )
