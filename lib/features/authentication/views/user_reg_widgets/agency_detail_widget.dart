import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_detail_bloc.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';

class AgencyDetail extends ConsumerStatefulWidget {
  const AgencyDetail({
    required this.inputBorder,
    super.key,
    required this.inputDecoration,
  });
  final InputBorder inputBorder;
  final InputDecoration inputDecoration;

  @override
  ConsumerState<AgencyDetail> createState() => _AgencyDetailState();
}

class _AgencyDetailState extends ConsumerState<AgencyDetail> {
  @override
  Widget build(BuildContext context) => ref.watch(agencyDetailProvider).when(
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
                          '소속기관 선택',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      isDense: true,
                      isExpanded: true,
                      value: ref.watch(selectedAgencyProvider).id,
                      items: data
                          .map(
                            (e) => DropdownMenuItem(
                              alignment: Alignment.center,
                              value: e.id,
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  e.instNm ?? '',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () {
                          final model = ref.read(selectedAgencyProvider);
                          final selectedModel =
                              data.firstWhere((e) => e.id == value);

                          model.rgstUserId = selectedModel.rgstUserId;
                          model.rgstDttm = selectedModel.rgstDttm;
                          model.updtUserId = selectedModel.updtUserId;
                          model.updtDttm = selectedModel.updtDttm;
                          model.id = selectedModel.id;
                          model.instTypeCd = selectedModel.instTypeCd;
                          model.instNm = selectedModel.instNm;
                          model.dstrCd1 = selectedModel.dstrCd1;
                          model.dstrCd2 = selectedModel.dstrCd2;
                          model.chrgId = selectedModel.chrgId;
                          model.chrgNm = selectedModel.chrgNm;
                          model.chrgTelno = selectedModel.chrgTelno;
                          model.baseAddr = selectedModel.baseAddr;
                          model.lat = selectedModel.lat;
                          model.lon = selectedModel.lon;
                          model.rmk = selectedModel.rmk;
                          model.attcId = selectedModel.attcId;

                          final user = ref.watch(regUserProvider);

                          user.instId = selectedModel.id;
                          user.instNm = selectedModel.instNm;
                          user.instTypeCd = selectedModel.instTypeCd;
                          user.dutyAddr = selectedModel.baseAddr;
                          user.dutyDstr1Cd = selectedModel.dstrCd1;
                          user.dutyDstr2Cd = selectedModel.dstrCd2;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.h14,
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: widget.inputBorder,
                  focusedBorder: widget.inputBorder,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.5,
                    horizontal: 18,
                  ),
                  hintText: '소속기관명',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
