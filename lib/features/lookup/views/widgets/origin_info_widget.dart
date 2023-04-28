import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';

class OriginInfomation extends ConsumerStatefulWidget {
  OriginInfomation({
    required this.formKey,
    super.key,
  });
  final GlobalKey<FormState> formKey;
  final _homeTitles = [
    '보호자1 연락처',
    '보호자2 연락처',
    '배정 요청 메세지',
  ];
  final _hospitalTitles = [
    '진료과',
    '담당의',
    '전화번호',
    '원내 배정 여부',
    '요청 메세지',
  ];
  final _subTitles = [
    '환자 출발지',
    '배정 요청 지역',
  ];
  final _classification = [
    '자택',
    '병원',
    '기타',
  ];
  final _assignedToTheFloorTitles = [
    '전원요청',
    '원내배정',
  ];
  @override
  ConsumerState<OriginInfomation> createState() => _OriginInfomationState();
}

class _OriginInfomationState extends ConsumerState<OriginInfomation> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < widget._subTitles.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${i + 1}.${widget._subTitles[i]}',
                        style: const TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 18,
                        ),
                      ),
                      if (i == 0)
                        Row(
                          children: [
                            for (int i = 0; i < widget._classification.length; i++)
                              _initClassification(widget._classification[i], _selectedOriginIndex, i, () => setState(() => _selectedOriginIndex = i)),
                          ],
                        )
                      else if (i == 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5 - 18,
                                child: _selectLocalGovernment(),
                              ),
                              Gaps.v4,
                              const Text(
                                '※병상배정 지자체 선택',
                                style: TextStyle(
                                  color: Color(0xFF4CAFF1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (i == 0)
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: _initTextField(true),
                            ),
                            Gaps.h6,
                            Expanded(
                              flex: 3,
                              child: _initSearchBtn(),
                            ),
                          ],
                        ),
                      if (i == 0) Gaps.v8,
                      if (i == 0) _initTextField(true),
                      Gaps.v36,
                    ],
                  ),
                if (_selectedOriginIndex == 0)
                  for (int i = 0; i < widget._homeTitles.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${i + 3}.${widget._homeTitles[i]}',
                          style: const TextStyle(
                            color: Color(0xFF808080),
                            fontSize: 18,
                          ),
                        ),
                        Gaps.v4,
                        _initTextField(true),
                        Gaps.v36,
                      ],
                    )
                else if (_selectedOriginIndex == 1)
                  for (int i = 0; i < widget._hospitalTitles.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${i + 3}.${widget._hospitalTitles[i]}',
                          style: const TextStyle(
                            color: Color(0xFF808080),
                            fontSize: 18,
                          ),
                        ),
                        Gaps.v4,
                        if (i < 3)
                          _initTextField(true)
                        else if (i == 3)
                          Row(
                            children: [
                              for (int i = 0; i < widget._assignedToTheFloorTitles.length; i++)
                                _initClassification(widget._assignedToTheFloorTitles[i], assignedToTheFloor, i, () => setState(() => assignedToTheFloor = i)),
                            ],
                          )
                        else if (i == 4)
                          _initTextField(false),
                        Gaps.v36,
                      ],
                    ),
              ],
            ),
          ),
        ),
      );
  Widget _selectLocalGovernment() => ref.watch(agencyRegionProvider).when(
        loading: () => const SBASProgressIndicator(),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(
              color: Palette.mainColor,
            ),
          ),
        ),
        data: (region) => InputDecorator(
          decoration: _inputDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 8,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: const SizedBox(
                  width: 150,
                  child: Text(
                    '시/도 선택',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                isDense: true,
                isExpanded: true,
                items: region
                    .where((e) => e.id?.cdGrpId == 'SIDO')
                    .map(
                      (e) => DropdownMenuItem(
                        alignment: Alignment.center,
                        value: e.cdNm,
                        child: SizedBox(
                          width: 150,
                          child: Text(
                            e.cdNm ?? '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
              ),
            ),
          ),
        ),
      );
  Widget _initTextField(bool isSingleLine) => TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 22,
          ),
        ),
        inputFormatters: [
          if (isSingleLine)
            FilteringTextInputFormatter.allow(
              RegExp(r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|ㆍ|ᆢ]'),
            ),
          if (isSingleLine) FilteringTextInputFormatter.singleLineFormatter,
        ],
        validator: (value) {
          return null;
        },
        onSaved: (newValue) {
          if (newValue != null && newValue.isNotEmpty) {}
        },
        autovalidateMode: AutovalidateMode.always,
        maxLines: isSingleLine ? 1 : null,
        keyboardType: isSingleLine ? TextInputType.streetAddress : TextInputType.multiline,
        textInputAction: isSingleLine ? null : TextInputAction.newline,
      );
  Widget _initSearchBtn() => TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF538EF5)),
          minimumSize: MaterialStateProperty.all(
            const Size(
              double.infinity,
              18 * 3 - 2,
            ),
          ),
        ),
        child: const Text(
          '우편번호 검색',
          style: TextStyle(
            color: Color(0xFFECEDEF),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
  Widget _initClassification(String title, int selectedIndex, int index, Function() func) => GestureDetector(
        onTap: func,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          margin: const EdgeInsets.only(
            top: 6,
            bottom: 8,
            right: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, style: selectedIndex == index ? BorderStyle.none : BorderStyle.solid),
            color: selectedIndex == index ? Palette.mainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(
              18,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
          ),
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
  int _selectedOriginIndex = -1, assignedToTheFloor = -1;
}
