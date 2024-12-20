import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/providers/agency_detail_provider.dart';
import 'package:sbas/features/authentication/providers/agency_region_bloc.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/providers/user_reg_bloc.dart';

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
  Widget build(BuildContext context) {
    var dutyDstr1Cd = ref.read(regUserProvider).dutyDstr1Cd;

    return ref.watch(agencyRegionProvider).when(
      loading: () => const SBASProgressIndicator(),
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
          style: CTS(
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                dutyDstr1Cd == null || dutyDstr1Cd == '' ? '\'시/도\'를 선택해주세요.' : null,
              builder: (field) => SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputDecorator(
                      decoration: widget.inputDecoration,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: SizedBox(
                            width: 150,
                            child: Text(
                              '시/도 선택',
                              style:
                              CTS(fontSize: 13.sp, color: Palette.black),
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
                                  style: CTS(
                                      fontSize: 13.sp,
                                      color: Palette.black),
                                ),
                              ),
                            ),
                          )
                              .toList(),
                          onChanged: (value) => setState(
                                () {
                              final model = ref.read(selectedRegionProvider);

                              final selectedModel =
                              data.firstWhere((e) => value == e.cdNm);

                              ref.read(selectedCountyProvider).cdNm = null;

                              model.cdGrpId = selectedModel.cdGrpId;
                              model.cdGrpNm = selectedModel.cdGrpNm;
                              model.cdId = selectedModel.cdId;
                              model.cdNm = selectedModel.cdNm;
                              model.cdSeq = selectedModel.cdSeq;
                              model.cdVal = selectedModel.cdVal;
                              model.rmk = selectedModel.rmk;
                              ref.watch(regUserProvider).dutyDstr1Cd =
                                  selectedModel.cdId;

                              ref
                                  .read(agencyRegionProvider.notifier)
                                  .exchangeTheCounty();

                              field.didChange(selectedModel.cdNm);
                            },
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
              // initialValue: ref.watch(selectedCountyProvider).cdNm,
              // validator: (value) => value == null || value.isEmpty ? '\'시/군/구\'를 선택해주세요.' : null,
              builder: (field) => SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputDecorator(
                      decoration: widget.inputDecoration,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: const SizedBox(
                            width: 150,
                            child: Text(
                              '시/군/구 선택',
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
                          items: [
                            DropdownMenuItem(
                              value: '시/군/구 전체',
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  '시/군/구 전체',
                                  textAlign: TextAlign.center,
                                  style: CTS(
                                      fontSize: 13.sp, color: Palette.black),
                                ),
                              ),
                            ),
                            ...data
                                .where((e) =>
                            e.cdGrpId != null &&
                                e.cdGrpId!.length > 4)
                                .map(
                                  (e) => DropdownMenuItem(
                                alignment: Alignment.center,
                                value: e.cdNm,
                                child: SizedBox(
                                  width: 150,
                                  child: Text(
                                    e.cdNm ?? '',
                                    textAlign: TextAlign.center,
                                    style: CTS(
                                        fontSize: 13.sp,
                                        color: Palette.black),
                                  ),
                                ),
                              ),
                            )
                                .toList()
                          ],
                          onChanged: (value) => setState(
                                () {
                              final model = ref.read(selectedCountyProvider);
                              if (value == '시/군/구 전체') {
                                model.cdNm = '시/군/구 전체';
                                model.cdId = null;
                                ref.watch(regUserProvider).dutyDstr2Cd = null;
                                field.didChange(null);
                              } else {
                                final selectedModel =
                                data.firstWhere((e) => value == e.cdNm);

                                final agency =
                                ref.watch(selectedAgencyProvider);

                                agency.instNm = null;
                                agency.id = null;

                                model.cdGrpId = selectedModel.cdGrpId;
                                model.cdGrpNm = selectedModel.cdGrpNm;
                                model.cdId = selectedModel.cdId;
                                model.cdNm = selectedModel.cdNm;
                                ref.watch(regUserProvider).dutyDstr2Cd =
                                    selectedModel.cdId;

                                field.didChange(selectedModel.cdNm);
                              }
                              ref
                                  .read(agencyDetailProvider.notifier)
                                  .exchangeTheAgency();
                            },
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
}
