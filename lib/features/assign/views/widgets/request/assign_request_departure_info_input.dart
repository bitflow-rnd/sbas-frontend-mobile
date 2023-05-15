import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

final selecteItemProvider0 = StateProvider((ref) => 0);
final selecteItemProvider1 = StateProvider((ref) => 0);

class AssignReqDepatureInfoInputScreen extends ConsumerWidget {
  AssignReqDepatureInfoInputScreen({
    super.key,
  });
  final List<String> list = [
    '배정요청지역',
    '원내 배정 여부',
    '환자 출발지',
    '진료과',
    '담당의',
    '연락처',
    '메시지',
    '보호자 1 연락처',
    '보호자 2 연락처',
  ];
  final hintTextList = [
    '배정요청지역',
    '원내 배정 여부',
    '환자 출발지',
    '진료과 입력',
    '담당의 입력',
    '연락처 입력',
    '메시지 입력',
    '보호자 1 연락처 입력',
    '보호자 2 연락처 입력',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected0 = ref.watch(selecteItemProvider0);
    final selected1 = ref.watch(selecteItemProvider1);

    return Expanded(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),
            child: Column(
              children: [
                _getTitle(list[0], true),
                Gaps.v16,
                one(),
                Gaps.v28,
                //
                _getTitle(list[1], true),
                Gaps.v16,
                rowSelectButton(
                    ['전원요청', '원내배졍'], selected0, ref, selecteItemProvider0),
                Gaps.v28,
                //
                _getTitle(list[2], false),
                Gaps.v16,
                rowSelectButton(
                    ['병원', '자택', '기타'], selected1, ref, selecteItemProvider1),
                Gaps.v16,
                twelve(),
                Gaps.v28,
                //
                selected1 == 0
                    ? Column(
                        //병원
                        children: [
                          _getTitle(list[3], true),
                          Gaps.v16,
                          _getTextInputField(hint: hintTextList[3]),
                          Gaps.v28,
                          //
                          _getTitle(list[4], false),
                          Gaps.v16,
                          _getTextInputField(hint: hintTextList[4]),
                          Gaps.v28,
                          //
                          _getTitle(list[5], false),
                          Gaps.v16,
                          _getTextInputField(hint: hintTextList[5]),
                          Gaps.v28,
                          //
                          _getTitle(list[6], false),
                          Gaps.v16,
                          _getTextInputField(
                              hint: hintTextList[6], maxLines: 6),
                          Gaps.v28,
                        ],
                      )
                    : Column(
                        // 자택, 기타
                        children: [
                          _getTitle(list[3], false),
                          Gaps.v16,
                          _getTextInputField(hint: hintTextList[3]),
                          Gaps.v28,
                          //
                          _getTitle(list[7], false),
                          Gaps.v16,
                          _getTextInputField(hint: hintTextList[7]),
                          Gaps.v28,
                          //
                          _getTitle(list[8], false),
                          Gaps.v16,
                          _getTextInputField(hint: hintTextList[8]),
                          Gaps.v28,
                          //
                          _getTitle(list[6], false),
                          Gaps.v16,
                          _getTextInputField(
                              hint: hintTextList[6], maxLines: 6),
                          Gaps.v28,
                        ],
                      )
              ],
            ),
          ),
        ],
      )),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: !selectList.contains(i)
                        ? Colors.white
                        : Palette.mainColor,
                    border: Border.all(
                      color: Palette.greyText_20,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(13.5.r),
                  ),
                  child: Text(i,
                      style: CTS.bold(
                        fontSize: 13,
                        color: selectList.contains(i)
                            ? Palette.white
                            : Palette.greyText_60,
                      )),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget one() {
    List<String> dropdownList = ['대구광역시', '최근3개월', '최근1년'];

    String selectedDropdown = '대구광역시';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
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
              child: Text(
                "※ 병상배정 지자체 선택",
                style: CTS(color: Palette.mainColor, fontSize: 12),
              ).c,
            )
          ],
        ),
        Gaps.v12,
        Text(
          "안내문구 노출 영역",
          style: CTS(color: Palette.red, fontSize: 11),
          textAlign: TextAlign.start,
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
                              color: list[selected] == i
                                  ? const Color(0xff538ef5)
                                  : Colors.transparent,
                              borderRadius: list[selected] == i
                                  ? BorderRadius.circular(6)
                                  : null),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(i,
                              style: CTS.bold(
                                fontSize: 11,
                                color: list[selected] == i
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

  Widget _getTextInputField(
      {required String hint,
      TextInputType type = TextInputType.text,
      int? maxLines,
      List<TextInputFormatter>? inputFormatters}) {
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
            !isRequired ? '(선택)' : '(필수)',
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
}
