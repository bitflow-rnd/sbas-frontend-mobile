import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/providers/agency_detail_provider.dart';
import 'package:sbas/features/authentication/providers/user_reg_bloc.dart';

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
  final TextEditingController textEditingController = TextEditingController();
  bool isReadOnly = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(regUserProvider);
    final model = ref.read(selectedAgencyProvider);

    return ref.watch(agencyDetailProvider).when(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: FormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: ref.watch(selectedAgencyProvider).instId,
              validator: (value) => value == null || value == '' ? '소속기관을 선택해주세요.' : null,
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
                              '소속기관 선택',
                              style: CTS(
                                color: Colors.grey,
                                fontSize: 13.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          isDense: true,
                          isExpanded: true,
                          value: ref.watch(selectedAgencyProvider).instNm,
                          items: [
                            DropdownMenuItem(
                              value: '직접입력',
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  '직접입력',
                                  textAlign: TextAlign.center,
                                  style: CTS(
                                      fontSize: 13.sp, color: Palette.black),
                                ),
                              ),
                            ),
                            ...data
                                .map(
                                  (e) => DropdownMenuItem(
                                alignment: Alignment.center,
                                value: e.instNm,
                                child: SizedBox(
                                  width: 150,
                                  child: Text(
                                    e.instNm ?? '',
                                    textAlign: TextAlign.center,
                                    style: CTS(
                                        fontSize: 13.sp,
                                        color: Palette.black),
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                          ],
                          onChanged: (value) => setState(() {
                              textEditingController.text = '';

                              if (value == '직접입력') {
                                user.instId = 'INST000000';
                                user.instNm = null;
                                model.instNm = '직접입력';
                                // model.instId = 'INST000000';
                                isReadOnly = false;
                              } else {
                                final selectedModel = data.firstWhere((e) => e.instNm == value);
                                model.instNm = selectedModel.instNm;
                                model.instId = selectedModel.instId;

                                // textEditingController.text = selectedModel.instNm ?? '';
                                isReadOnly = true;
                                user.instId = selectedModel.instId;
                                user.instNm = selectedModel.instNm;
                              }
                              field.didChange(user.instId);
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
          Gaps.h14,
          Expanded(
            child: TextFormField(
              readOnly: isReadOnly,
              controller: textEditingController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => user.instNm == null || user.instNm == '' ? '소속기관을 입력해주세요.' : null,
              style: CTS(fontSize: 13.sp, color: Palette.black),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                enabledBorder: widget.inputBorder,
                focusedBorder: widget.inputBorder,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.5.h,
                  horizontal: 18.r,
                ),
                hintText: '기관명 직접 입력',
                hintStyle: CTS(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              onChanged: (value) {
                user.instNm = textEditingController.text;
              },
            ),
          ),
        ],
      ),
    );
  }
}
