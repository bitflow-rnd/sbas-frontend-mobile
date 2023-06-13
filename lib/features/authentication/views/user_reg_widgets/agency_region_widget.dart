import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_detail_bloc.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/constants/palette.dart';

class AgencyRegion extends ConsumerStatefulWidget {
  const AgencyRegion({
    required this.inputDecoration,
    super.key,
  });
  final InputDecoration inputDecoration;

  @override
  ConsumerState<AgencyRegion> createState() => _AgencyRegionState();
}

class _AgencyRegionState extends ConsumerState<AgencyRegion> {
  @override
  Widget build(BuildContext context) => ref.watch(agencyRegionProvider).when(
        loading: () => const SBASProgressIndicator(),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(
              color: Palette.mainColor,
            ),
          ),
        ),
        data: (data) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: FormField(
                initialValue: ref.watch(selectedRegionProvider).cdNm,
                autovalidateMode: AutovalidateMode.always,
                validator: (value) => value == null || value.isEmpty ? '\'시/도\'를 선택해주세요.' : null,
                builder: (field) => SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: widget.inputDecoration,
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
                              value: ref.watch(selectedRegionProvider).cdNm,
                              items: data
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
                              onChanged: (value) => setState(
                                () {
                                  final model = ref.read(selectedRegionProvider);

                                  final selectedModel = data.firstWhere((e) => value == e.cdNm);

                                  ref.read(selectedCountyProvider).cdNm = null;

                                  model.cdGrpId = selectedModel.cdGrpId;
                                  model.cdGrpNm = selectedModel.cdGrpNm;
                                  model.cdId = selectedModel.cdId;
                                  model.cdNm = selectedModel.cdNm;
                                  model.cdSeq = selectedModel.cdSeq;
                                  model.cdVal = selectedModel.cdVal;
                                  model.rmk = selectedModel.rmk;

                                  ref.read(agencyRegionProvider.notifier).exchangeTheCounty();

                                  field.didChange(selectedModel.cdNm);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (field.hasError) Gaps.v12,
                      if (field.hasError)
                        FieldErrorText(
                          field: field,
                        )
                    ],
                  ),
                ),
              ),
            ),
            Gaps.h14,
            Expanded(
              flex: 1,
              child: FormField(
                autovalidateMode: AutovalidateMode.always,
                initialValue: ref.watch(selectedCountyProvider).cdNm,
                validator: (value) => value == null || value.isEmpty || ref.watch(selectedCountyProvider).cdNm == null ? '\'시/구/군\'을 선택해주세요.' : null,
                builder: (field) => SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: widget.inputDecoration,
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
                              value: ref.watch(selectedCountyProvider).cdNm,
                              items: data
                                  .where((e) => e.cdGrpId != null && e.cdGrpId!.length > 4)
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
                              onChanged: (value) => setState(
                                () {
                                  final model = ref.read(selectedCountyProvider);

                                  final selectedModel = data.firstWhere((e) => value == e.cdNm);

                                  final agency = ref.watch(selectedAgencyProvider);

                                  agency.instNm = null;
                                  agency.id = null;

                                  model.cdGrpId = selectedModel.cdGrpId;
                                  model.cdGrpNm = selectedModel.cdGrpNm;
                                  model.cdId = selectedModel.cdId;
                                  model.cdNm = selectedModel.cdNm;
                                  model.cdSeq = selectedModel.cdSeq;
                                  model.cdVal = selectedModel.cdVal;
                                  model.rmk = selectedModel.rmk;

                                  ref.read(agencyDetailProvider.notifier).exchangeTheAgency();

                                  field.didChange(selectedModel.cdNm);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (field.hasError) Gaps.v12,
                      if (field.hasError)
                        FieldErrorText(
                          field: field,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
