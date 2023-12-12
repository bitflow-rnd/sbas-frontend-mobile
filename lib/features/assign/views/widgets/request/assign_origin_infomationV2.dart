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
  });
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
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    int selectedOriginIndex = ref.watch(selectedOriginIndexProvider.notifier).state;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
        data: (origin) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 18,
          ),
          child: Column(
            children: [
              for (int i = 0; i < widget._subTitles.length; i++)
                if (i == 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTitle(widget._subTitles[i], true),
                      Gaps.v8,
                      Row(
                        children: [
                          Expanded(
                              child: _selectRegion(origin.reqDstr1Cd),
                          ),
                          Expanded(
                            child: Text(
                              "※ 병상배정 지자체 선택",
                              style: CTS(color: Palette.mainColor, fontSize: 13),
                            ).c,
                          )
                        ],
                      ),
                    ],
                  )
                else if (i == 1)
                  Column(
                    children: [
                      Gaps.v16,
                      _getTitle("환자 출발지 유형", true),
                      Gaps.v8,
                      _initRowClassification(widget._classification, false, ref),
                    ],
                  ),
              Column(
                children: [
                  Gaps.v8,
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
                          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
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
                  Gaps.v24,
                ],
              ),
              if (selectedOriginIndex == 0)
                for (int i = 0; i < widget._homeTitles.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTitle(widget._homeTitles[i], false),
                      Gaps.v8,
                      _initTextField(i + 103, true),
                      Gaps.v16,
                    ],
                  )
              else if (selectedOriginIndex == 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTitle("원내 배정 여부", true),
                    Gaps.v8,
                    _initRowClassification(widget._assignedToTheFloorTitles, true, ref),
                    Gaps.v8,
                    for (int i = 0; i < widget._hospitalTitles.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getTitle(widget._hospitalTitles[i], false),
                          Gaps.v8,
                          _initTextField(i + 3 + 1000, false),
                          Gaps.v16,
                        ],
                      ),
                  ],
                )
            ]
          ),
        ),
      ),
    );
  }

  Widget _initRowClassification(List<String> list, bool isAssign, WidgetRef ref) {

    String? dprtDstrTypeCd = ref.read(originInfoProvider.notifier).getDprtDstrTypeCd();
    String? inhpAsgnYn = ref.read(originInfoProvider.notifier).getInhpAsgnYn();

    int selectedOriginIndex = ref.watch(selectedOriginIndexProvider.notifier).state;
    int assignedToTheFloor = ref.watch(selectedIndexProvider.notifier).state;

    return FormField(
      initialValue: list[0] == '자택' ? dprtDstrTypeCd : inhpAsgnYn,
      validator: (value) {
        if (list[0] == '자택') {
          return dprtDstrTypeCd == null || dprtDstrTypeCd == '' ? '환자 출발지 유형을 선택해 주세요.' : null;
        } else if (list[0] == '전원요청') {
          return inhpAsgnYn == null ? '원내 배정 여부를 선택해 주세요.' : null;
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
                            ref.read(selectedIndexProvider.notifier).update((state) => state = val);
                            field.didChange(inhpAsgnYn);
                          } else {
                            var val = await ref.read(originInfoProvider.notifier).setOriginIndex(i);
                            ref.read(selectedOriginIndexProvider.notifier).update((state) => state = val);
                            field.didChange(dprtDstrTypeCd);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: (isAssign ? assignedToTheFloor : selectedOriginIndex) == i ? const Color(0xff538ef5) : Colors.transparent,
                                    borderRadius: (isAssign ? assignedToTheFloor : selectedOriginIndex) == i ? BorderRadius.circular(6) : null),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  list[i],
                                  style: CTS.bold(
                                    fontSize: 11,
                                    color: (isAssign ? assignedToTheFloor : selectedOriginIndex) == i ? Palette.white : Palette.greyText_60,
                                  ),
                                ),
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
            validator: (value) {
              return ref.watch(selectedRegionProvider).cdId == null ||
                      ref.watch(selectedRegionProvider).cdId == ''
                  ? '배정 요청 지역을 선택해주세요.'
                  : null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (field) => SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: Text(
                                    e.cdNm ?? '',
                                    style: const TextStyle(fontSize: 13, color: Palette.black),
                                    textAlign: TextAlign.left,
                                  ),
                              ),
                            )
                            .toList(),
                        hint: Text(
                            '시/도 선택',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                            textAlign: TextAlign.left,
                          ),
                        isDense: true,
                        isExpanded: true,
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            try {
                              final selectRegion = region.firstWhere((e) => value == e.cdId);
                              ref.read(originInfoProvider.notifier).selectLocalGovernment(selectRegion);
                              field.didChange(value);
                            } catch (e) {
                              debugPrint("error ${e.toString()}");
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
              color: Palette.mainColor,
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
