import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/agency_detail_bloc.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/lookup/presenters/origin_info_presenter.dart';

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
                  data: (origin) => Column(
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
                                  for (int i = 0;
                                      i < widget._classification.length;
                                      i++)
                                    _initClassification(
                                      widget._classification[i],
                                      _selectedOriginIndex,
                                      i,
                                      () async => _selectedOriginIndex =
                                          await ref
                                              .read(originInfoProvider.notifier)
                                              .setOriginIndex(i),
                                    ),
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
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                                  0.5 -
                                              30,
                                          child: _selectLocalGovernment(
                                              origin.reqDstr1Cd),
                                        ),
                                        Gaps.h4,
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.5 -
                                              12,
                                          child: _selectLocalCounty(
                                              origin.reqDstr1Cd),
                                        ),
                                      ],
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
                                    child: _initTextField(i, true),
                                  ),
                                  Gaps.h6,
                                  Expanded(
                                    flex: 3,
                                    child: _initSearchBtn(),
                                  ),
                                ],
                              ),
                            if (i == 0) Gaps.v8,
                            if (i == 0) _initTextField(i + 100, true),
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
                              _initTextField(i + 103, true),
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
                              if (i != 3)
                                _initTextField(i + 3 + 1000, i != 4)
                              else
                                Row(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            widget._assignedToTheFloorTitles
                                                .length;
                                        i++)
                                      _initClassification(
                                        widget._assignedToTheFloorTitles[i],
                                        _assignedToTheFloor,
                                        i,
                                        () async => _assignedToTheFloor =
                                            await ref
                                                .read(
                                                    originInfoProvider.notifier)
                                                .setAssignedToTheFloor(i),
                                      ),
                                  ],
                                ),
                              Gaps.v36,
                            ],
                          ),
                    ],
                  ),
                ),
          ),
        ),
      );
  Widget _selectLocalGovernment(String? code) =>
      ref.watch(agencyRegionProvider).when(
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
                        .where((e) => e.cdGrpId == 'SIDO')
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
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        final selectRegion =
                            region.firstWhere((e) => e.cdNm == value).cdId;

                        if (selectRegion != null && selectRegion.isNotEmpty) {
                          ref
                              .read(originInfoProvider.notifier)
                              .selectLocalGovernment(selectRegion);
                        }
                      }
                    },
                    value: region
                        .firstWhere(
                          (e) => e.cdId == code,
                          orElse: () => BaseCodeModel(),
                        )
                        .cdNm,
                  ),
                ),
              ),
            ),
          );
  Widget _selectLocalCounty(String? code) {
      // print("${ref.watch(agencyRegionProvider.notifier).selectTheCounty(region)}");
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
                    '시/구/군 선택',
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
                    .where((e) => e.cdId == code)
                    .map(
                      (e) => DropdownMenuItem(
                    alignment: Alignment.center,
                    value: ref.read(agencyRegionProvider.notifier).selectTheCounty(e),
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
                onChanged: (value) {
                  if (value != null) {
                    final selectRegion =
                        region.firstWhere((e) => e.cdNm == value).cdId;

                    if (selectRegion != null && selectRegion.isNotEmpty) {
                      ref
                          .read(originInfoProvider.notifier)
                          .selectLocalCounty(selectRegion);
                    }
                  }
                },
                value: '',
              ),
            ),
          ),
        ),
      );
  }
  Widget _initTextField(int index, bool isSingleLine) {
    final notifier = ref.watch(originInfoProvider.notifier);

    return TextFormField(
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
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade400,
        ),
        hintText: notifier.getHintText(index),
      ),
      inputFormatters: [
        if (isSingleLine)
          FilteringTextInputFormatter.allow(
            RegExp(r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|\s|ㆍ|ᆢ]'),
          ),
        if (isSingleLine) FilteringTextInputFormatter.singleLineFormatter,
      ],
      validator: (value) {
        return null;
      },
      onChanged: (value) => notifier.onChanged(index, value),
      autovalidateMode: AutovalidateMode.always,
      maxLines: isSingleLine ? 1 : null,
      keyboardType:
          isSingleLine ? TextInputType.streetAddress : TextInputType.multiline,
      textInputAction: isSingleLine ? null : TextInputAction.newline,
      controller: TextEditingController(
        text: notifier.getText(index),
      ),
      readOnly: index == 0,
    );
  }

  Widget _initSearchBtn() => TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KpostalView(
              kakaoKey: dotenv.env['KAKAO'] ?? '',
              callback: (postal) =>
                  ref.read(originInfoProvider.notifier).setAddress(postal),
            ),
          ),
        ),
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
          '주소검색',
          style: TextStyle(
            color: Color(0xFFECEDEF),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
  Widget _initClassification(
          String title, int selectedIndex, int index, Function() func) =>
      GestureDetector(
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
            border: Border.all(
                color: Colors.grey,
                style: selectedIndex == index
                    ? BorderStyle.none
                    : BorderStyle.solid),
            color:
                selectedIndex == index ? Palette.mainColor : Colors.transparent,
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
  int _selectedOriginIndex = -1, _assignedToTheFloor = -1;
}
