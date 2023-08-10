import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/severely_disease_presenter.dart';

final selecteItemProvider0 = StateProvider((ref) => 0);
final selecteItemProvider1 = StateProvider((ref) => 0);
final selecteItemProvider2 = StateProvider((ref) => 0);
final selecteItemProvider3 = StateProvider((ref) => 0);
final selecteItemProvider4 = StateProvider((ref) => 0);
final selecteItemProvider5 = StateProvider((ref) => 0);

class SeverelyDiseaseV2 extends ConsumerStatefulWidget {
  SeverelyDiseaseV2({
    required this.formKey,
    required this.ptId,
    super.key,
  });

  final String ptId;
  final GlobalKey<FormState> formKey;
  final List<String> list = [
    '중증여부',
    '요청병상유형',
    'DNR 동의 여부',
    '환자 유형',
    '기저질환',
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

  @override
  ConsumerState<SeverelyDiseaseV2> createState() => _SeverelyDiseaseV2State();
}

class _SeverelyDiseaseV2State extends ConsumerState<SeverelyDiseaseV2> {
  @override
  Widget build(BuildContext context) {
    final selected0 = ref.watch(selecteItemProvider0);
    final selected1 = ref.watch(selecteItemProvider1);
    final selected2 = ref.watch(selecteItemProvider2);
    final selected3 = ref.watch(selecteItemProvider3);
    final selected4 = ref.watch(selecteItemProvider4);
    final selected5 = ref.watch(selecteItemProvider5);
    return ref.watch(severelyDiseaseProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Palette.mainColor,
              ),
            ),
          ),
          data: (model) => Form(
            autovalidateMode: AutovalidateMode.always,
            key: widget.formKey,
            child: Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTitle(widget.list[0], true),
                    Gaps.v16,
                    rowSelectButton(['직접선택', '생체정보분석', '미분류'], selected0, ref, selecteItemProvider0),
                    Gaps.v16,
                    selected0 == 0
                        ? Column(
                            children: [
                              rowSelectButton(['중증', '준중증', '준등중'], selected1, ref, selecteItemProvider1),
                            ],
                          )
                        : selected0 == 1
                            ? Column(
                                children: [
                                  Divider(
                                    color: Palette.greyText_20,
                                    height: 1.2,
                                  ),
                                  Gaps.v8,
                                  Row(
                                    children: [
                                      Text(
                                        '의식상태',
                                        style: CTS(color: Palette.greyText, fontSize: 13),
                                      ),
                                      const Spacer(),
                                      SizedBox(width: 110.h, child: rowSelectButton(['명료', '비명료'], selected4, ref, selecteItemProvider4)),
                                    ],
                                  ),
                                  Gaps.v8,
                                  Row(
                                    children: [
                                      Text(
                                        '의식상태',
                                        style: CTS(color: Palette.greyText, fontSize: 13),
                                      ),
                                      const Spacer(),
                                      SizedBox(width: 110.h, child: rowSelectButton(['비투여', '투여'], selected5, ref, selecteItemProvider5)),
                                    ],
                                  ),
                                  SizedBox(
                                      height: 300.h,
                                      child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.57,
                                        ),
                                        itemBuilder: (context, index) => Padding(
                                          padding: EdgeInsets.only(
                                              top: 12.h,
                                              bottom: 12.h,
                                              right: index % 2 == 0 ? 6.w : 0,
                                              left: index % 2 == 1 ? 6.w : 0), //왼쪽 줄, 오른쪽 줄 위젯 안쪽만 패딩줌.
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget._labelTitles[index],
                                                style: CTS.medium(color: Palette.greyText, fontSize: 13),
                                              ),
                                              Gaps.v8,
                                              index == 5
                                                  ? Expanded(
                                                      child: InkWell(
                                                        onTap: () {},
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
                                                  : TextFormField(
                                                      decoration: getInputDecoration(widget._labelTitlesHint[index]),
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(
                                                          RegExp(r'[0-9|.]'),
                                                        ),
                                                        FilteringTextInputFormatter.singleLineFormatter,
                                                      ],
                                                      validator: (value) {
                                                        return null;

                                                        // if (value != null && value.isNotEmpty && (int.tryParse(value) is int || double.tryParse(value) is double)) {
                                                        //   return null;
                                                        // }
                                                        // return '수치를 정확히 입력하세요.';
                                                      },
                                                      onSaved: (newValue) {
                                                        if (newValue != null && newValue.isNotEmpty) {
                                                          switch (index) {
                                                            case 0:
                                                              // model.bdTemp = double.tryParse(newValue);
                                                              break;

                                                            case 1:
                                                              // model.pulse = int.tryParse(newValue);
                                                              break;

                                                            case 2:
                                                              // model.breath = int.tryParse(newValue);
                                                              break;

                                                            case 3:
                                                              // model.spo2 = double.tryParse(newValue);
                                                              break;

                                                            case 4:
                                                              // model.sbp = int.tryParse(newValue);
                                                              break;
                                                          }
                                                        }
                                                      },
                                                      autovalidateMode: AutovalidateMode.always,
                                                    ),
                                            ],
                                          ),
                                        ),
                                        itemCount: widget._labelTitles.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                      )),
                                ],
                              )
                            : Container(),
                    Gaps.v28,
                    //요청병상유형
                    _getTitle(widget.list[1], true),
                    Gaps.v16,
                    rowSelectButton(['일반격리', '음압격리', '미분류'], selected2, ref, selecteItemProvider2),
                    Gaps.v28,
                    //DNR 동의 여부
                    _getTitle(widget.list[2], true),
                    Gaps.v16,
                    rowSelectButton(['미분류', '동의', '비동의'], selected3, ref, selecteItemProvider3),
                    Gaps.v28,
                    //환자유형(다중선택)
                    _getTitle(widget.list[3], true),
                    Gaps.v16,
                    rowMultiSelectButton(['임산부', '투석', '수술', '신생아', '유아', '인공호흡기 사용', '적극적치료요쳥'], ['임산부']),
                    Gaps.v28,
                    //기저질환(다중선택)
                    _getTitle(widget.list[3], true),
                    Gaps.v16,
                    rowMultiSelectButton(['고혈압', '당뇨', '고지혈증', '  심혈관  ', '뇌혈관', '암', '만성폐질환', '폐렴', '신장질환', '결핵', '천식등알레르기', '면역력저하자'], ['고혈압']),
                    Gaps.v16,
                    _getTextInputField(hint: "기타 직접입력"),
                    Gaps.v28,
                  ],
                ),
              ),
            ),
          ),
        );
  }
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

Widget rowSelectButton(list, selected, WidgetRef ref, p) {
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
                      child: Text(i, style: CTS.bold(fontSize: 11, color: Colors.transparent)),
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
                  selected = list.indexOf(i);
                  ref.watch(p.notifier).state = selected;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: list[selected] == i ? const Color(0xff538ef5) : Colors.transparent,
                            borderRadius: list[selected] == i ? BorderRadius.circular(6) : null),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(i,
                            style: CTS.bold(
                              fontSize: 11,
                              color: list[selected] == i ? Palette.white : Palette.greyText_60,
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
          (title == '환자 유형' || title == '기저 질환') ? '(다중선택)' : '(필수)',
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
