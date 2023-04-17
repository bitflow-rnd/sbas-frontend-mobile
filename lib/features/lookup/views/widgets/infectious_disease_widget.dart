import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/lookup/blocs/infectious_disease_bloc.dart';

class InfectiousDisease extends ConsumerStatefulWidget {
  InfectiousDisease({
    required this.formKey,
    super.key,
  });
  @override
  ConsumerState<InfectiousDisease> createState() => _InfectiousDiseaseState();

  final _titles = [
    '담당보건소',
    '코로나19증상 및 징후',
    '확진검사결과',
    '질병급',
    '발병일',
    '환자등 분류',
    '비고',
    '입원여부',
    '요양기관명',
    '요양기관기호',
    '요양기관주소',
    '요양기관 전화번호',
    '진단의사 성명',
    '신고기관장 성명',
    '기타 진료정보 이미지·영상',
  ];
  final GlobalKey<FormState> formKey;
}

class _InfectiousDiseaseState extends ConsumerState<InfectiousDisease> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(infectiousDiseaseProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          data: (patient) => Form(
            key: widget.formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget._titles.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(i + 1)}.${widget._titles[i]}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        Gaps.v4,
                        if (i == 0)
                          FormField(
                            builder: (field) => ref
                                .watch(agencyRegionProvider)
                                .when(
                                  loading: () => const SBASProgressIndicator(),
                                  error: (error, stackTrace) => Center(
                                    child: Text(
                                      error.toString(),
                                      style: const TextStyle(
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                  data: (region) =>
                                      _selectRegion(region, field),
                                ),
                          ),
                        Gaps.v12,
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
  }

  Widget _selectRegion(
          List<BaseCodeModel> region, FormFieldState<Object?> field) =>
      SizedBox(
        child: Column(
          children: [
            InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
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
                  onChanged: (value) {},
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
