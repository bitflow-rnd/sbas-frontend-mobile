import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';

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
  Widget build(BuildContext context) => ref.watch(agencyRegionProvider).when(
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(
              Colors.lightBlueAccent,
            ),
          ),
        ),
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
                      value: ref.watch(selectedRegionProvider).cdNm,
                      items: data
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
                      onChanged: (value) => setState(() {
                        final model = ref.read(selectedRegionProvider);
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
                      }),
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
