import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/bio_info_presenter.dart';
import 'package:sbas/features/lookup/blocs/severely_disease_presenter.dart';
import 'package:sbas/features/lookup/models/bio_info_model.dart';

class SeverelyDisease extends ConsumerStatefulWidget {
  SeverelyDisease({
    required this.formKey,
    super.key,
  });
  final GlobalKey<FormState> formKey;
  final _subTitles = [
    '환자유형',
    '기저질환',
    '중증도 분류',
    '요청 병상유형',
    'DNR 동의 여부',
  ];
  final _classification = [
    '직접선택',
    '생체정보 입력분석',
    '알수없음',
    '명료',
    '비명료',
    '비투여',
    '투여',
  ];
  final _labelTitles = [
    '체온(℃)',
    '맥박(회/분)',
    '분당호흡수(회/분)',
    '산소포화도(％)',
    '수축기혈압(mmHg)',
  ];
  @override
  ConsumerState<SeverelyDisease> createState() => _SeverelyDiseaseState();
}

class _SeverelyDiseaseState extends ConsumerState<SeverelyDisease> {
  Widget _initClassification(int selectedIndex, int index, Function() func) =>
      GestureDetector(
        onTap: func,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey,
                style: selectedIndex == index
                    ? BorderStyle.none
                    : BorderStyle.solid),
            color:
                selectedIndex == index ? Colors.lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(
              18,
            ),
          ),
          child: Text(
            widget._classification[index],
            style: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
          ),
        ),
      );
  Widget _initGridView<T>(
    int subIndex,
    Iterable<BaseCodeModel> model,
    SliverGridDelegate sliverGridDelegate,
  ) =>
      GridView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        gridDelegate: sliverGridDelegate,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            final key = model.toList()[index].id?.cdId;

            if (key != null && key.isNotEmpty) {
              final isChecked = ref.watch(checkedSeverelyDiseaseProvider)[key];

              if (isChecked != null) {
                setState(() {
                  final state =
                      ref.read(checkedSeverelyDiseaseProvider.notifier).state;

                  state[key] = !isChecked;

                  if (subIndex > 1) {
                    for (var e in state.keys) {
                      if (e.substring(0, 4) == key.substring(0, 4) &&
                          e != key) {
                        state[e] = isChecked;
                      }
                    }
                  }
                });
              }
            }
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey,
                  style: ref.watch(checkedSeverelyDiseaseProvider)[
                              model.toList()[index].id?.cdId] ==
                          true
                      ? BorderStyle.none
                      : BorderStyle.solid),
              color: ref.watch(checkedSeverelyDiseaseProvider)[
                          model.toList()[index].id?.cdId] ==
                      true
                  ? Colors.lightBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(
                18,
              ),
            ),
            child: Text(
              model.toList()[index].cdNm ?? '',
              style: TextStyle(
                color: ref.watch(checkedSeverelyDiseaseProvider)[
                            model.toList()[index].id?.cdId] ==
                        true
                    ? Colors.white
                    : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
            ),
          ),
        ),
        itemCount: model.length,
        physics: const NeverScrollableScrollPhysics(),
      );
  Widget _init(BioInfoModel model) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.15,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(2),
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade300,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade300,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade300,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 22,
              ),
              labelText: widget._labelTitles[index],
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9|.]'),
              ),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  (int.tryParse(value) is int ||
                      double.tryParse(value) is double)) {
                return null;
              }
              return '수치를 정확히 입력하세요.';
            },
            onSaved: (newValue) {
              if (newValue != null && newValue.isNotEmpty) {
                switch (index) {
                  case 0:
                    model.bdTemp = double.tryParse(newValue);
                    break;

                  case 1:
                    model.pulse = double.tryParse(newValue);
                    break;

                  case 2:
                    model.breath = double.tryParse(newValue);
                    break;

                  case 3:
                    model.spo2 = double.tryParse(newValue);
                    break;

                  case 4:
                    model.sbp = double.tryParse(newValue);
                    break;
                }
              }
            },
            autovalidateMode: AutovalidateMode.always,
          ),
        ),
        itemCount: widget._labelTitles.length,
        physics: const NeverScrollableScrollPhysics(),
      );
  Widget _initBioInfo() => ref.watch(bioInfoProvider).when(
        loading: () => const SBASProgressIndicator(),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        data: (bio) => Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.grey,
              ),
              FormField(
                autovalidateMode: AutovalidateMode.always,
                builder: (field) => Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          '의식상태',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        Gaps.h12,
                        for (int i = 3; i < 5; i++)
                          _initClassification(
                            _selectedStateIndex,
                            i,
                            () => setState(() {
                              _selectedStateIndex = i;
                              bio.avpu = i == 3 ? 'A' : 'U';
                              field.didChange(bio.avpu);
                            }),
                          ),
                      ],
                    ),
                    Gaps.v6,
                    if (field.hasError)
                      FieldErrorText(
                        field: field,
                      ),
                  ],
                ),
                validator: (value) => value != null ? null : '의식상태를 선택하세요.',
              ),
              FormField(
                autovalidateMode: AutovalidateMode.always,
                builder: (field) => Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          '산소 투여 여부',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        Gaps.h12,
                        for (int i = 5; i < widget._classification.length; i++)
                          _initClassification(
                            _selectedOxygenIndex,
                            i,
                            () => setState(() {
                              _selectedOxygenIndex = i;
                              bio.o2Apply = i == 5 ? 'N' : 'Y';
                              field.didChange(bio.o2Apply);
                            }),
                          ),
                      ],
                    ),
                    Gaps.v6,
                    if (field.hasError)
                      FieldErrorText(
                        field: field,
                      ),
                  ],
                ),
                validator: (value) => value != null ? null : '산소 투여 여부를 선택하세요.',
              ),
              SizedBox(
                height: (128 + 32).h,
                child: _init(bio),
              ),
              const Text(
                '※생체정보를 모두 입력하신 경우에 A.I.분석이 가능합니다.',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 2,
                  top: 4,
                  right: 2,
                  bottom: 18,
                ),
                child: TextButton(
                  onPressed: _submit,
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size(
                        MediaQuery.of(context).size.width,
                        18 * 3,
                      ),
                    ),
                  ),
                  child: const Text(
                    '분석',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  Future<void> _submit() async {
    if (widget.formKey.currentState != null &&
        widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();

      _score = await ref.read(bioInfoProvider.notifier).analyze();
    }
  }

  @override
  Widget build(BuildContext context) => ref.watch(severelyDiseaseProvider).when(
        loading: () => const SBASProgressIndicator(),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        data: (model) => GestureDetector(
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
                        Gaps.v2,
                        Text(
                          '${i + 1}.${widget._subTitles[i]}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        if (i == 2)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0; i < 3; i++)
                                      _initClassification(
                                        _selectedIndex,
                                        i,
                                        () =>
                                            setState(() => _selectedIndex = i),
                                      ),
                                  ],
                                ),
                              ),
                              Gaps.v6,
                              if (_selectedIndex == 1 && _score == 0)
                                _initBioInfo(),
                              if (_selectedIndex == 0 || _selectedIndex == 1)
                                const Text(
                                  '중증도 분석 결과',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              if (_selectedIndex == 1 && _score > 0)
                                Column(
                                  children: [
                                    Gaps.v4,
                                    Text(
                                      'NEWS Score: $_score',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    const Text(
                                      '※중증도 분석 A.I.시스템의 분석 값 입니다.',
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        if (i == 0)
                          SizedBox(
                            height: _getHeight(
                              model.where((e) => e.id?.cdGrpId == 'PTTP'),
                              4,
                            ),
                            child: _initGridView(
                              i,
                              model.where((e) => e.id?.cdGrpId == 'PTTP'),
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.925,
                              ),
                            ),
                          )
                        else if (i == 1)
                          SizedBox(
                            height: _getHeight(
                              model.where((e) => e.id?.cdGrpId == 'UDDS'),
                              3,
                            ),
                            child: _initGridView(
                              i,
                              model.where((e) => e.id?.cdGrpId == 'UDDS'),
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.325,
                              ),
                            ),
                          )
                        else if (i == 2 &&
                            (_selectedIndex == 0 || _selectedIndex == 1))
                          SizedBox(
                            height: _getHeight(
                              model.where((e) => e.id?.cdGrpId == 'SVTP'),
                              4,
                            ),
                            child: _initGridView(
                              i,
                              model.where((e) => e.id?.cdGrpId == 'SVTP'),
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.925,
                              ),
                            ),
                          )
                        else if (i == 3)
                          SizedBox(
                            height: _getHeight(
                              model.where((e) => e.id?.cdGrpId == 'BDTP'),
                              4,
                            ),
                            child: _initGridView(
                              i,
                              model.where((e) => e.id?.cdGrpId == 'BDTP'),
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.925,
                              ),
                            ),
                          )
                        else if (i == 4)
                          SizedBox(
                            height: _getHeight(
                              model.where((e) => e.id?.cdGrpId == 'DNRA'),
                              4,
                            ),
                            child: _initGridView(
                              i,
                              model.where((e) => e.id?.cdGrpId == 'DNRA'),
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.925,
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      );
  double _getHeight(Iterable<BaseCodeModel> model, int crossAxisCount) =>
      (model.length / crossAxisCount + 1) * 54.h;

  int _selectedIndex = -1,
      _selectedStateIndex = -1,
      _selectedOxygenIndex = -1,
      _score = 0;
}
