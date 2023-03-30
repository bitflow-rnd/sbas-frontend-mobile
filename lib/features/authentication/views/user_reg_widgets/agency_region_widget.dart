import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/progress_indicator.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_detail_bloc.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';

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
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        data: (data) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: InputDecorator(
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
                      onChanged: (value) => setState(
                        () {
                          final model = ref.read(selectedRegionProvider);

                          final selectedModel =
                              data.firstWhere((e) => value == e.cdNm);

                          ref.read(selectedCountyProvider).cdNm = null;

                          model.cdGrpNm = selectedModel.cdGrpNm;
                          model.cdNm = selectedModel.cdNm;
                          model.cdSeq = selectedModel.cdSeq;
                          model.cdVal = selectedModel.cdVal;
                          model.id = selectedModel.id;
                          model.rgstDttm = selectedModel.rgstDttm;
                          model.rgstUserId = selectedModel.rgstUserId;
                          model.rmk = selectedModel.rmk;
                          model.updtDttm = selectedModel.updtDttm;
                          model.updtUserId = selectedModel.updtUserId;

                          ref.read(agencyRegionProvider.notifier).addCounty();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.h14,
            Expanded(
              flex: 1,
              child: InputDecorator(
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
                          .where((e) =>
                              e.id != null &&
                              e.id?.cdGrpId != null &&
                              e.id!.cdGrpId!.length > 4)
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

                          final selectedModel =
                              data.firstWhere((e) => value == e.cdNm);

                          model.cdGrpNm = selectedModel.cdGrpNm;
                          model.cdNm = selectedModel.cdNm;
                          model.cdSeq = selectedModel.cdSeq;
                          model.cdVal = selectedModel.cdVal;
                          model.id = selectedModel.id;
                          model.rgstDttm = selectedModel.rgstDttm;
                          model.rgstUserId = selectedModel.rgstUserId;
                          model.rmk = selectedModel.rmk;
                          model.updtDttm = selectedModel.updtDttm;
                          model.updtUserId = selectedModel.updtUserId;

                          ref
                              .read(agencyDetailProvider.notifier)
                              .selectAgency();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
