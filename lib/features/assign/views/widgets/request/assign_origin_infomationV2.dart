import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/lookup/presenters/origin_info_presenter.dart';

class OriginInfomationV2 extends ConsumerStatefulWidget {
  OriginInfomationV2({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  final _homeTitles = [
    '보호자 1 연락처',
    '보호자 2 연락처',
    '메시지',
  ];
  final _hospitalTitles = [
    '진료과',
    '담당의',
    '연락처',
    // '원내 배정 여부',
    '메시지',
  ];
  final _subTitles = [
    '배정 요청 지역',
    '환자 출발지',
  ];
  final _assignedToTheFloorTitles = [
    '전원요청',
    '원내배정',
  ];
  final _classification = [
    '자택',
    '병원',
    '기타',
  ];
  @override
  ConsumerState<OriginInfomationV2> createState() => _OriginInfomationStateV2();
}

class _OriginInfomationStateV2 extends ConsumerState<OriginInfomationV2> {
  int _selectedOriginIndex = -1, _assignedToTheFloor = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 18.h,
                  ),
                  child: ref.watch(originInfoProvider).when(
                        loading: () => const SBASProgressIndicator(),
                        error: (error, stackTrace) => Center(
                          child: Text(
                            error.toString(),
                            style: CTS(
                              color: Palette.mainColor,
                            ),
                          ),
                        ),
                        data: (origin) => Column(children: [
                          for (int i = 0; i < widget._subTitles.length; i++)
                            if (i == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle(widget._subTitles[i], true),
                                  Gaps.v12,
                                  Row(
                                    children: [
                                      Expanded(child: _selectRegion(origin.reqDstr1Cd)),
                                      Expanded(
                                        child: Text(
                                          "※ 병상배정 지자체 선택",
                                          style: CTS(color: Palette.mainColor, fontSize: 12),
                                        ).c,
                                      )
                                    ],
                                  ),
                                  // Text(
                                  //   "안내문구 노출 영역",
                                  //   style: CTS(color: Palette.red, fontSize: 11),
                                  //   textAlign: TextAlign.start,
                                  // ),
                                  if (_selectedOriginIndex == 1) //병원 출발기준
                                    Column(
                                      children: [
                                        Gaps.v28,
                                        _getTitle("원내 배정 여부", true),
                                        Gaps.v16,
                                        _initRowClassification(
                                          widget._assignedToTheFloorTitles,
                                          true,
                                        ),
                                      ],
                                    ),
                                ],
                              )
                            else if (i == 1)
                              Column(
                                children: [
                                  Gaps.v28,
                                  _getTitle("환자 출발지", false),
                                  Gaps.v16,
                                  _initRowClassification(
                                    widget._classification,
                                    false,
                                  ),
                                ],
                              ),
                          Column(
                            children: [
                              Gaps.v14,
                              Row(
                                children: [
                                  Expanded(child: _initTextField(0, true)),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => KpostalView(
                                          kakaoKey: dotenv.env['KAKAO'] ?? '',
                                          callback: (postal) => ref.read(originInfoProvider.notifier).setAddress(postal),
                                        ),
                                      ),
                                    ),
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
                              _initTextField(100, true),
                              Gaps.v28,
                            ],
                          ),
                          if (_selectedOriginIndex == 0)
                            for (int i = 0; i < widget._homeTitles.length; i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle(widget._homeTitles[i], false),
                                  Gaps.v4,
                                  _initTextField(i + 103, true),
                                  Gaps.v36,
                                ],
                              )
                          else if (_selectedOriginIndex == 1)
                            for (int i = 0; i < widget._hospitalTitles.length; i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle(widget._hospitalTitles[i], false),
                                  Gaps.v8,
                                  _initTextField(i + 3 + 1000, false),
                                  Gaps.v36,
                                ],
                              ),
                        ]),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _initRowClassification(List<String> list, bool isAssign) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffe4e4e4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              for (int i = 0; i < list.length; i++)
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(list[i], style: CTS.bold(fontSize: 11, color: Colors.transparent)),
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
            for (int i = 0; i < list.length; i++)
              Expanded(
                child: InkWell(
                  onTap: () async {
                    if (isAssign) {
                      var val = await ref.read(originInfoProvider.notifier).setAssignedToTheFloor(i);
                      setState(() {
                        _assignedToTheFloor = val;
                      });
                    } else {
                      var val = await ref.read(originInfoProvider.notifier).setOriginIndex(i);
                      setState(() {
                        _selectedOriginIndex = val;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: (isAssign ? _assignedToTheFloor : _selectedOriginIndex) == i ? const Color(0xff538ef5) : Colors.transparent,
                              borderRadius: (isAssign ? _assignedToTheFloor : _selectedOriginIndex) == i ? BorderRadius.circular(6) : null),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(list[i],
                              style: CTS.bold(
                                fontSize: 11,
                                color: (isAssign ? _assignedToTheFloor : _selectedOriginIndex) == i ? Palette.white : Palette.greyText_60,
                              )),
                        ),
                      ),
                      list[i] != list.last
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

  Widget _selectRegion(String? code) {
    return ref.watch(agencyRegionProvider).when(
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
            initialValue: ref.watch(selectedRegionProvider).cdId,
            builder: (field) => SizedBox(
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
                                    style: TextStyle(fontSize: 13, color: Palette.black),
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
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        isDense: true,
                        isExpanded: true,
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            try {
                              final selectRegion = region.firstWhere((e) => value == e.cdId);
                              ref.read(originInfoProvider.notifier).selectLocalGovernment(selectRegion);
                            } catch (e) {
                              print("erro${e.toString()}");
                            }
                          }
                        },
                        value: region
                            .firstWhere(
                              (e) => e.cdId == code,
                              orElse: () => BaseCodeModel(),
                            )
                            .cdId,
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
            ),
          ),
        );
  }

  Widget rowMultiSelectButton(list, selectList) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 11.w,
            runSpacing: 12.h,
            direction: Axis.horizontal,
            children: [
              for (var i in list)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: !selectList.contains(i) ? Colors.white : Palette.mainColor,
                    border: Border.all(
                      color: Palette.greyText_20,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(13.5.r),
                  ),
                  child: Text(i,
                      style: CTS.bold(
                        fontSize: 13,
                        color: selectList.contains(i) ? Palette.white : Palette.greyText_60,
                      )),
                )
            ],
          ),
        ),
      ],
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
            !isRequired ? '(선택)' : '(필수)',
            style: CTS.medium(
              fontSize: 13,
              color: !isRequired ? Colors.grey.shade600 : Palette.mainColor,
            ),
          ),
        ],
      );

  Widget _initTextField(int index, bool isSingleLine) {
    final notifier = ref.watch(originInfoProvider.notifier);
    final TextEditingController textController = TextEditingController(text: notifier.getText(index));

    return TextFormField(
      style: CTS.regular(fontSize: 13.sp),
      decoration: InputDecoration(
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
          hintText: notifier.getHintText(index),
          hintStyle: CTS.regular(
            fontSize: 13.sp,
            color: Palette.greyText_60,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          )),
      inputFormatters: [
        if (isSingleLine)
          FilteringTextInputFormatter.allow(
            RegExp(r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|\s|ㆍ|ᆢ]'),
          ),
        if (isSingleLine) FilteringTextInputFormatter.singleLineFormatter,
      ],
      // validator: (value) {
      //   return null;
      // },
      onChanged: (value) => notifier.onChanged(index, value),
      autovalidateMode: AutovalidateMode.always,
      maxLines: isSingleLine ? 1 : null,
      keyboardType: isSingleLine ? TextInputType.streetAddress : TextInputType.multiline,
      textInputAction: isSingleLine ? null : TextInputAction.newline,
      controller: textController
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length)),
      readOnly: index == 0,
    );
  }

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
}
