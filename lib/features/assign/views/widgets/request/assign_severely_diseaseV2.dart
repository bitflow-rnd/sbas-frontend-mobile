import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/bio_info_presenter.dart';
import 'package:sbas/features/lookup/presenters/severely_disease_presenter.dart';

import '../../../../../common/widgets/field_error_widget.dart';

class SeverelyDiseaseV2 extends ConsumerStatefulWidget {
  SeverelyDiseaseV2({
    required this.ptId,
    super.key,
  });

  final String ptId;
  final List<String> _subTitles = [
    '중증도 분류', //  2     : SVTP (cpGrpId)
    '요청병상유형', //  3  : BDTP (cpGrpId)
    'DNR 동의 여부', //4  : DNRA (cpGrpId)
    '환자유형', //0    : PPTP (cpGrpId)
    '기저질환', //1-    : UDDS (cpGrpId)
  ];
  final _labelTitles = [
    '체온(℃)',
    '맥박(회/분)',
    '분당호흡수(회/분)',
    '산소포화도(％)',
    '수축기혈압(mmHg)',
    '',
  ];
  final _labelTitlesHint = [
    '℃',
    '회/분',
    '회/분',
    '％',
    'mmHg',
    '',
  ];
  final _classification = [
    '명료',
    '비명료',
    '비투여',
    '투여',
  ];

  @override
  ConsumerState<SeverelyDiseaseV2> createState() => _SeverelyDiseaseV2State();
}

class _SeverelyDiseaseV2State extends ConsumerState<SeverelyDiseaseV2> {
  int _selectedIndex = -1, _selectedStateIndex = -1, _selectedOxygenIndex = -1, _score = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ref.watch(severelyDiseaseProvider).when(
        loading: () => const SBASProgressIndicator(),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(
              color: Palette.mainColor,
            ),
          ),
        ),
        data: (model) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < widget._subTitles.length; i++)
                if (i == 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTitle(widget._subTitles[i], true),
                      Gaps.v8,
                      _initRowClassification(ref.watch(severelyDiseaseProvider.notifier).list.where((e) => e.cdGrpId == 'SVIP'), isFirst: true),
                      // _initRowClassification(model.where((e) => e.cdGrpId == 'SVIP'), isFirst: true),
                      Visibility(
                        visible: _selectedIndex == 1 && _score == 0,
                        child: _initBioInfo(),
                      ),
                      if (_selectedIndex == 1)
                        Column(
                          children: [
                            _getTitle("중증도 분석 결과", true),
                          ],
                        ),
                      if (_selectedIndex == 1 && _score > 0)
                        Column(
                          children: [
                            Gaps.v20,
                            Text(
                              'NEWS Score: $_score',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            const Text(
                              '※중증도 분석 A.I.시스템의 분석 값 입니다.',
                              style: TextStyle(
                                color: Palette.mainColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      if (_selectedIndex == 0 || _selectedIndex == 1)
                        Column(
                          children: [
                            Gaps.v8,
                            _initRowClassification(ref.watch(severelyDiseaseProvider.notifier).list.where((e) => e.cdGrpId == 'SVTP')),
                            // 이부분도 디자인과 다름. 디자인상 중증/준중증/준등증 으로 되어있지만.
                            //실제 SVTP 로 조회시 무증상~사망의 7개 나옴. 일단 디자인과 동일하게 구현.
                          ],
                        ),
                    ],
                  )
                else if (i == 1)
                  Column(
                    children: [
                      Gaps.v8,
                      _getTitle(widget._subTitles[i], true),
                      Gaps.v8,
                      _initRowClassification(ref.watch(severelyDiseaseProvider.notifier).list.where((e) => e.cdGrpId == 'BDTP')),
                    ],
                  )
                else if (i == 2)
                  Column(
                    children: [
                      Gaps.v8,
                      _getTitle(widget._subTitles[i], true),
                      Gaps.v8,
                      _initRowClassification(ref.watch(severelyDiseaseProvider.notifier).list.where((e) => e.cdGrpId == 'DNRA')),
                    ],
                  )
                else if (i == 3)
                  Column(
                    children: [
                      Gaps.v8,
                      _getTitle(widget._subTitles[i], true),
                      Gaps.v8,
                      rowMultiSelectButton(ref.watch(severelyDiseaseProvider.notifier).list.where((e) => e.cdGrpId == 'PTTP'), i),
                    ],
                  )
                else if (i == 4)
                  Column(
                    children: [
                      Gaps.v8,
                      _getTitle(widget._subTitles[i], false),
                      Gaps.v8,
                      rowMultiSelectButton(ref.watch(severelyDiseaseProvider.notifier).list.where((e) => e.cdGrpId == 'UDDS'), i),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _initBioInfo() {
    var svrtIptTypeCd = ref.read(severelyDiseaseProvider.notifier).severelyDiseaseModel.svrtIptTypeCd;
    svrtIptTypeCd == 'SVIP0001' ? _selectedIndex = 0 : _selectedIndex = 1;

    return ref.watch(bioInfoProvider).when(
      loading: () => const SBASProgressIndicator(),
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
          style: const TextStyle(
            color: Palette.mainColor,
          ),
        ),
      ),
      data: (bio) => Column(
        children: [
          Divider(
            color: Palette.greyText_20,
            height: 1.2,
          ),
          Gaps.v8,
          FormField(
            autovalidateMode: AutovalidateMode.always,
            builder: (field) => Column(
              children: [
                Row(
                  children: [
                    Text(
                      '의식상태',
                      style: CTS(color: Palette.greyText, fontSize: 13),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          width: 110.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffe4e4e4),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              for (int i = 0; i < 2; i++)
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 10.h),
                                        child: Text("", style: CTS.bold(fontSize: 11, color: Colors.transparent)),
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
                            for (int i = 0; i < 2; i++)
                              _initClassification(
                                widget._classification[i],
                                _selectedStateIndex,
                                i,
                                    () => setState(
                                      () {
                                    _selectedStateIndex = i;
                                    bio.avpu = i == 0 ? 'A' : 'U';
                                    field.didChange(bio.avpu);
                                  },
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            validator: (value) => value != null ? null : '의식상태를 선택하세요.',
          ),
          Gaps.v8,
          FormField(
            autovalidateMode: AutovalidateMode.always,
            validator: (value) => value != null ? null : '산소 투여 여부를 선택하세요.',
            builder: (field) => Column(
              children: [
                Row(
                  children: [
                    Text(
                      '산소 투여 여부',
                      style: CTS(color: Palette.greyText, fontSize: 13),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          width: 110.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffe4e4e4),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              for (int i = 0; i < 2; i++)
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 10.h),
                                        child: Text("", style: CTS.bold(fontSize: 11, color: Colors.transparent)),
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
                            for (int i = 2; i < 4; i++)
                              _initClassification(
                                widget._classification[i],
                                _selectedOxygenIndex,
                                i,
                                    () => setState(() {
                                  _selectedOxygenIndex = i;
                                  bio.o2Apply = i == 4 ? 'N' : 'Y';
                                  field.didChange(bio.o2Apply);
                                }),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300.h,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.57,
              ),
              itemBuilder: (context, index) => Padding(
                padding:
                EdgeInsets.only(top: 12.h, bottom: 12.h, right: index % 2 == 0 ? 6.w : 0, left: index % 2 == 1 ? 6.w : 0), //왼쪽 줄, 오른쪽 줄 위젯 안쪽만 패딩줌.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget._labelTitles[index],
                      style: CTS.medium(color: Palette.greyText, fontSize: 13),
                    ),
                    Gaps.v8,
                    index != 5
                        ? TextFormField(
                      style: CTS.regular(fontSize: 13.sp, color: Palette.black),
                      decoration: getInputDecoration(widget._labelTitlesHint[index]),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9|.]'),
                        ),
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      validator: (value) {
                        if (value != null && value.isNotEmpty && (int.tryParse(value) is int || double.tryParse(value) is double)) {
                          return null;
                        }
                        return null;
                        // return '수치를 정확히 입력하세요.';
                      },
                      onSaved: (newValue) {
                        if (newValue != null && newValue.isNotEmpty) {
                          switch (index) {
                            case 0:
                              bio.bdTemp = double.tryParse(newValue);
                              break;
                            case 1:
                              bio.pulse = int.tryParse(newValue);
                              break;
                            case 2:
                              bio.breath = int.tryParse(newValue);
                              break;
                            case 3:
                              bio.spo2 = double.tryParse(newValue);
                              break;
                            case 4:
                              bio.sbp = int.tryParse(newValue);
                              break;
                          }
                        }
                      },
                      autovalidateMode: AutovalidateMode.always,
                    )
                        : Expanded(
                      child: InkWell(
                        onTap: () {
                          _submit();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Palette.white,
                            border: Border.all(
                              color: Palette.mainColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text('분석',
                              style: CTS.bold(
                                fontSize: 13,
                                color: Palette.mainColor,
                              )).c,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              itemCount: widget._labelTitles.length,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      )
    );
  }

  final _formKey = GlobalKey<FormState>();
  Future<void> _submit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _score = await ref.read(bioInfoProvider.notifier).analyze(widget.ptId);
    }
  }

  Widget _initRowClassification(Iterable<BaseCodeModel> model, {bool? isFirst = false}) {
    var list = model.map((e) => e.cdNm).toList();
    if (model.first.cdGrpId == 'SVTP') {
      // list.add("중증");
      // list.add("준중증");
      // list.add("준등중");
    } else {
      if (list.length > 3) list = list.sublist(0, 3); // 기존 디자인과 다르기에 3개만 보여줌.
    }

    var severelyDiseaseModel = ref.watch(severelyDiseaseProvider.notifier).severelyDiseaseModel;
    String? initValue;

    return FormField(
      initialValue: initValue,
      validator: (value) {
        if (model.first.cdGrpId == 'SVIP') {
          return severelyDiseaseModel.svrtIptTypeCd == null || severelyDiseaseModel.svrtIptTypeCd == ''
              ? '중증도 입력유형을 선택해 주세요.' : null;
        } else if (model.first.cdGrpId == 'SVTP') {
          return severelyDiseaseModel.svrtTypeCd == null || severelyDiseaseModel.svrtTypeCd == ''
              ? '중증도를 선택해 주세요.' : null;
        } else if (model.first.cdGrpId == 'BDTP') {
          return severelyDiseaseModel.reqBedTypeCd == null || severelyDiseaseModel.reqBedTypeCd == ''
              ? '요청병상유형을 선택해 주세요.' : null;
        } else if (model.first.cdGrpId == 'DNRA') {
          return severelyDiseaseModel.dnrAgreYn == null || severelyDiseaseModel.dnrAgreYn == ''
              ? 'DNR 동의 여부를 선택해 주세요.' : null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
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
                              child: Text(list[i] ?? "", style: CTS.bold(fontSize: 11, color: Colors.transparent)),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ref.watch(checkedSeverelyDiseaseProvider)[model.toList()[i].cdId] == true ? const Color(0xff538ef5) : Colors.transparent,
                                    borderRadius: ref.watch(checkedSeverelyDiseaseProvider)[model.toList()[i].cdId] == true ? BorderRadius.circular(6) : null),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(list[i] ?? '',
                                    style: CTS.bold(
                                      fontSize: 11,
                                      color: ref.watch(checkedSeverelyDiseaseProvider)[model.toList()[i].cdId] == true ? Palette.white : Palette.greyText_60,
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
                        onTap: () {
                          setState(() {
                            if (isFirst == true && _selectedIndex != i) {
                              _selectedIndex = i;
                            }
                            final key = model.toList()[i].cdId;

                            if (key != null && key.isNotEmpty) {
                              if (model.first.cdGrpId == 'SVIP') {
                                severelyDiseaseModel.svrtIptTypeCd = key;
                              } else if (model.first.cdGrpId == 'SVTP') {
                                severelyDiseaseModel.svrtTypeCd = key;
                              } else if (model.first.cdGrpId == 'BDTP') {
                                severelyDiseaseModel.reqBedTypeCd = key;
                              } else if (model.first.cdGrpId == 'DNRA') {
                                severelyDiseaseModel.dnrAgreYn = key;
                              }

                              field.didChange(key);

                              final isChecked = ref.watch(checkedSeverelyDiseaseProvider)[key];

                              if (isChecked != null) {
                                final state = ref.read(checkedSeverelyDiseaseProvider.notifier).state;

                                if (state[key] == true) return;

                                state[key] = !isChecked;

                                for (var e in state.keys) {
                                  if (e.substring(0, 4) == key.substring(0, 4) && e != key) {
                                    state[e] = isChecked;
                                  }
                                }
                              }
                            }
                          });
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
          Gaps.v10,
          if (field.hasError)
            FieldErrorText(
              field: field,
            )
        ],
      )
    );
  }

  Widget _initClassification(String title, int selectedIndex, int index, Function() func) => GestureDetector(
        onTap: func,
        child: Container(
          width: 55.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
              color: selectedIndex == index ? const Color(0xff538ef5) : Colors.transparent,
              borderRadius: selectedIndex == index ? BorderRadius.circular(6) : null),
          child: Text(title,
              style: CTS.bold(
                fontSize: 11,
                color: index == selectedIndex ? Palette.white : Palette.greyText_60,
              )),
        ),
      );

  Widget rowMultiSelectButton(Iterable<BaseCodeModel> model, int subIndex) {
    var severelyDiseaseModel = ref.watch(severelyDiseaseProvider.notifier).severelyDiseaseModel;
    var list = model.toList();
    return FormField(
      initialValue: severelyDiseaseModel.pttp,
      validator: (value) {
        if (list.first.cdNm == '일반') {
          return severelyDiseaseModel.pttp.isEmpty
            ? '환자유형을 선택해주세요.' : null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 11.w,
                  runSpacing: 12.h,
                  direction: Axis.horizontal,
                  children: List.generate(
                    model.length,
                        (index) => GestureDetector(
                      onTap: () {
                        final key = model.toList()[index].cdId;
                        if (key != null && key.isNotEmpty) {
                          final isChecked = ref.watch(checkedSeverelyDiseaseProvider)[key];

                          if (isChecked != null) {
                            if (!isChecked) {
                              severelyDiseaseModel.pttp.add(key);
                            } else {
                              severelyDiseaseModel.pttp.remove(key);
                            }
                            field.didChange(severelyDiseaseModel.pttp);
                            setState(() {
                              final state = ref.read(checkedSeverelyDiseaseProvider.notifier).state;
                              state[key] = !isChecked;
                              //여러개 체크할수 있도록 수정
                              // for (var e in state.keys) {
                              //   if (e.substring(0, 4) == key.substring(0, 4) && e != key) {
                              //     state[e] = isChecked;
                              //   }
                              // }
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: ref.watch(checkedSeverelyDiseaseProvider)[model.toList()[index].cdId] != true ? Colors.white : Palette.mainColor,
                          border: Border.all(
                            color: Palette.greyText_20,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(13.5.r),
                        ),
                        child: Text(
                          model.toList()[index].cdNm ?? '',
                          style: CTS(
                            fontSize: 12.sp,
                            color: ref.watch(checkedSeverelyDiseaseProvider)[model.toList()[index].cdId] == true ? Palette.white : Palette.greyText_60,
                          ),
                        ),
                      ),
                    ),
                  )
                ),
                Gaps.v12,
                if (field.hasError)
                  FieldErrorText(
                    field: field,
                  )
              ],
            ),
          ),
        ],
      ),
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
            ((title == '환자유형' || title == '기저질환') ? '(다중선택)' : '') + (isRequired ? '(필수)' : ''),
            style: CTS.medium(
              fontSize: 13,
              color: (title == '환자 유형' || title == '기저 질환') ? Colors.grey.shade600 : Palette.mainColor,
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
}
