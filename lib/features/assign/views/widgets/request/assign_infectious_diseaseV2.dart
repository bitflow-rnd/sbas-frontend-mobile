import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/agency_detail_bloc.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/lookup/blocs/infectious_disease_bloc.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';

class InfectiousDiseaseV2 extends ConsumerStatefulWidget {
  InfectiousDiseaseV2({
    required this.report,
    this.dstr1Cd,
    this.dstr2Cd,
    super.key,
  });

  @override
  ConsumerState<InfectiousDiseaseV2> createState() => _InfectiousDiseaseV2State();

  final EpidemiologicalReportModel report;
  final List<String> status = ['입원', '외래', '재택', '기타'];
  String? selectedStatus;

  final String? dstr1Cd;
  final String? dstr2Cd;

  final List<String> list = [
    '입원여부', // 순서변경됨 i == 4 -> i==0
    '담당보건소', //
    '코로나19증상 및 징후',
    '확진검사결과',
    '질병급',
    '발병일',
    '진단일', //subtitle에서 넘김
    '신고일', //subtitle에서 넘김
    '환자등분류',
    '비고',
    '요양기관명',
    '요양기관기호',
    '요양기관 주소', //
    '요양기관 전화번호',
    '진단의사 성명',
    '신고기관장 성명',
    '기타 진료정보 이미지',
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
}

class _InfectiousDiseaseV2State extends ConsumerState<InfectiousDiseaseV2> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    InfectiousDiseaseBloc vm = ref.read(infectiousDiseaseProvider.notifier);
    final patientImage = ref.watch(infectiousImageProvider);
    ref.read(infectiousDiseaseProvider.notifier).initByOCR(widget.report);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: ref.watch(infectiousDiseaseProvider).when(
              loading: () => const SBASProgressIndicator(),
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(
                    color: Palette.mainColor,
                  ),
                ),
              ),
              data: (disease) => Column(
                children: [
                  for (int i = 0; i < widget.list.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getTitle(widget.list[i], true, vm),
                        Gaps.v4,
                        if (i == 0) //입원여부
                          Row(children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                    spacing: 12.w,
                                    runSpacing: 12.h,
                                    direction: Axis.horizontal,
                                    children: List.generate(
                                      widget.status.length,
                                      (index) {
                                        String key = widget.status.toList()[index];
                                        final isSelected = widget.selectedStatus == key;
                                        if (disease.admsYn != null && disease.admsYn!.isNotEmpty) {
                                          widget.selectedStatus = disease.admsYn;
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.selectedStatus = key;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 16.w),
                                            decoration: BoxDecoration(
                                              color: isSelected ? Palette.mainColor : Colors.white,
                                              border: Border.all(
                                                color: Palette.greyText_20,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(13.5.r),
                                            ),
                                            child: Text(
                                              widget.status.toList()[index] ??
                                                  '',
                                              style: CTS(
                                                fontSize: 13.sp,
                                                color: isSelected ? Palette.white : Palette.greyText_60,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                                Gaps.v20,
                              ],
                            ))
                          ])
                        else if (i == 1) // 담당보건소
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ref.watch(agencyRegionProvider).when(
                                          loading: () => const SBASProgressIndicator(),
                                          error: (error, stackTrace) => Center(
                                            child: Text(
                                              error.toString(),
                                              style: const TextStyle(
                                                color: Palette.mainColor,
                                              ),
                                            ),
                                          ),
                                          data: (region) => FormField(
                                            builder: (field) => _selectRegion(
                                              region.where(
                                                (e) => e.cdGrpId == 'SIDO',
                                              ),
                                              field,
                                            ),
                                            validator: (value) {
                                              return null;
                                            },
                                            initialValue: widget.dstr1Cd,
                                          ),
                                        ),
                                  ),
                                  Gaps.h8,
                                  Expanded(
                                    child: ref.watch(agencyDetailProvider).when(
                                          loading: () => const SBASProgressIndicator(),
                                          error: (error, stackTrace) => Center(
                                            child: Text(
                                              error.toString(),
                                              style: const TextStyle(
                                                color: Palette.mainColor,
                                              ),
                                            ),
                                          ),
                                          data: (publicHealthCenter) =>
                                              FormField(
                                            builder: (field) =>
                                                _selectPublicHealthCenter(
                                                    publicHealthCenter, field),
                                            validator: (value) {
                                              return null;
                                            },
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: _getTextInputField(
                                          hint: "보건소명 직접입력", vm: vm, i: i))
                                ],
                              ),
                            ],
                          )
                        else if (i == 12)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration:
                                          getInputDecoration("주소검색을 이용하여 입력"),
                                      controller: TextEditingController(
                                          text: vm.address),
                                      validator: (value) => null,
                                      readOnly: true,
                                      maxLines: 1,
                                      style: CTS(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => KpostalView(
                                          kakaoKey: dotenv.env['KAKAO'] ?? '',
                                          callback: (postal) =>
                                              vm.setAddress(postal),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 7.w),
                                      decoration: BoxDecoration(
                                        color: Palette.mainColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 28.w, vertical: 16.h),
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
                              _getTextInputField(hint: "상세주소 입력", vm: vm, i: i),
                              // 이부분 i 값 변경.
                            ],
                          )
                        else if (i == 16)
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final images = await picker.pickMultiImage();
                                  if(images.isNotEmpty) {
                                    ref.read(infectiousImageProvider.notifier).state = images;
                                  }
                                },
                                child: Stack(
                                  children: [
                                    if (patientImage.isNotEmpty)
                                      Column(
                                        children: patientImage.map((image) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10.h),
                                            child: Image.file(
                                              File(image.path),
                                              width: 0.8.sw,
                                            ),
                                          );
                                        }).toList(),
                                      )
                                    else
                                      Container(
                                        padding: EdgeInsets.all(20.r),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Palette.greyText_20),
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Image.asset(
                                          'assets/auth_group/camera_location.png',
                                          width: 80.w,
                                          height: 80.h,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Gaps.v20,
                            ],
                          )
                        else if (i == 5 || i == 6 || i == 7)
                          getDatePicker(widget.hintList[i], vm, i)
                        else
                          _getTextInputField(
                              hint: widget.hintList[i], vm: vm, i: i),
                      ],
                    ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _getTextInputField(
      {required String hint,
      required int i,
      required InfectiousDiseaseBloc vm,
      TextInputType type = TextInputType.text,
      int? maxLength,
      List<TextInputFormatter>? inputFormatters}) {
    return Column(
      children: [
        TextFormField(
          style: CTS(
            fontSize: 13.sp,
          ),
          decoration: getInputDecoration(hint),
          controller: TextEditingController(
            text: vm.init(i, widget.report),
          )..selection = TextSelection.fromPosition(
              TextPosition(offset: vm.init(i, widget.report)?.length ?? 0)),
          onSaved: (newValue) => vm.setTextEditingController(i, newValue),
          onChanged: (value) => vm.setTextEditingController(i, value),
          validator: (value) {
            if (i == 7) {}
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(
                  i == 0 ? r'[0-9|.-]' : r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|\s|ㆍ|ᆢ]'),
            ),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          autovalidateMode: AutovalidateMode.always,
          keyboardType: type,
          maxLength: maxLength,
        ),
        Gaps.v20,
      ],
    );
  }

  Widget getDatePicker(String hint, InfectiousDiseaseBloc vm, int i) {
    return Column(
      children: [
        TextFormField(
          style: CTS(
            fontSize: 13.sp,
          ),
          decoration: getInputDecoration(hint),
          controller: TextEditingController(
            text: vm.init(i, widget.report),
          ),
          readOnly: true,
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((selectedDate) {
              if (selectedDate != null) {
                setState(() {
                  vm.setTextEditingController(
                      i, DateFormat('yyyy-MM-dd').format(selectedDate));
                });
              }
            });
          },
        ),
        Gaps.v20,
      ],
    );
  }

  Widget _getTitle(String title, bool isRequired, InfectiousDiseaseBloc vm) =>
      Row(
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
          if (title == '발병일') const Spacer(),
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          String? r = vm.getOccrDt();
                          if (r != null && r.isNotEmpty) {
                            vm.setTextEditingController(6, r);
                            vm.setTextEditingController(7, r);
                          }
                        });
                      },
                      child: Text(
                        '전체동일',
                        style:
                            CTS.medium(fontSize: 13, color: Palette.mainColor),
                      ),
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
          fontSize: 14,
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

  Widget _selectRegion(
          Iterable<BaseCodeModel> region, FormFieldState<Object?> field) =>
      SizedBox(
        child: Column(
          children: [
            InputDecorator(
              decoration: getInputDecoration(""),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: region
                      .map(
                        (e) => DropdownMenuItem(
                          alignment: Alignment.center,
                          value: e.cdId,
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              e.cdNm ?? '',
                              style:
                                  TextStyle(fontSize: 13, color: Palette.black),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  hint: SizedBox(
                    width: 150,
                    child: Text(
                      '시/도 선택',
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade400),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  isDense: true,
                  isExpanded: true,
                  onChanged: (value) {
                    ref
                        .read(agencyDetailProvider.notifier)
                        .updatePublicHealthCenter(
                          region.firstWhere((e) => e.cdId == value).cdId ?? '',
                        );
                    ref
                        .read(infectiousDiseaseProvider.notifier)
                        .updateRegion("");
                    field.didChange(value);
                  },
                  value: field.value != '' ? field.value : null,
                ),
              ),
            ),
            Gaps.v8,
            if (field.hasError)
              FieldErrorText(
                field: field,
              )
          ],
        ),
      );

  Widget _selectPublicHealthCenter(
          Iterable<InfoInstModel> center, FormFieldState<Object?> field) =>
      SizedBox(
        child: Column(
          children: [
            InputDecorator(
              decoration: getInputDecoration(""),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: center
                      .map(
                        (e) => DropdownMenuItem(
                          alignment: Alignment.center,
                          value: e.instNm,
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              e.instNm ?? '',
                              style:
                                  TextStyle(fontSize: 13, color: Palette.black),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  hint: SizedBox(
                    width: 150,
                    child: Text(
                      '보건소 선택',
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade400),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  isDense: true,
                  isExpanded: true,
                  onChanged: (value) {
                    ref.read(infectiousDiseaseProvider.notifier).updateRegion(
                          center.firstWhere((e) => e.instNm == value).instNm ??
                              '',
                        );
                    field.didChange(value);
                  },
                  value: field.value != '' ? field.value : null,
                ),
              ),
            ),
            Gaps.v8,
            if (field.hasError)
              FieldErrorText(
                field: field,
              )
          ],
        ),
      );
}
