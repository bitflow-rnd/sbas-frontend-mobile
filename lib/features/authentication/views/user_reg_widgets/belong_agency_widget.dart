import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_detail_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_proof_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_region_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/util.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';

class BelongAgency extends ConsumerStatefulWidget {
  const BelongAgency({
    required this.titles,
    super.key,
  });
  final List<String> titles;

  @override
  ConsumerState<BelongAgency> createState() => _BelongAgencyState();
}

class _BelongAgencyState extends ConsumerState<BelongAgency> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(regUserProvider);
    final isCheckedMap = ref.watch(checkedPTTPProvicer);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getTitle(
          widget.titles[0],
          true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: AgencyRegion(
            inputDecoration: getInputDecoration(""),
          ),
        ),
        Gaps.v8,
        _getTitle(
          widget.titles[1],
          true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: AgencyDetail(
            inputBorder: _inputBorder,
            inputDecoration: getInputDecoration(""),
          ),
        ),
        Gaps.v12,
        _getTitle(
          widget.titles[2],
          false,
        ),
        Gaps.v12,
        FormField(
          autovalidateMode: AutovalidateMode.always,
          initialValue: ref.watch(checkedPTTPProvicer).containsValue(true),
          // validator: (value) => value == null || !value ? '※담당 환자 유형을 1개 이상 선택해주세요.' : null,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ref.watch(belongAgencyProvider).when(
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
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 11.w,
                            runSpacing: 12.h,
                            direction: Axis.horizontal,
                            children: List.generate(
                              data.length,
                              (index) {
                                final id = data[index].cdId!;
                                final isChecked = ref.watch(checkedPTTPProvicer);

                                return GestureDetector(
                                  onTap: () => setState(() {
                                    ref.read(checkedPTTPProvicer)[id] = !(ref.read(checkedPTTPProvicer)[id] ?? false);

                                    var checkedKeys = isCheckedMap.entries.where((entry) => entry.value == true).map((entry) => entry.key);
                                    user.ptTypeCd = checkedKeys.join(";");

                                    field.didChange(ref.watch(checkedPTTPProvicer).containsValue(true));
                                  }),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                                    decoration: BoxDecoration(
                                      color: isChecked[id] ?? false ? Palette.mainColor : Colors.transparent,
                                      border: Border.all(
                                        color: isChecked[id] ?? false ? Colors.transparent : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(13.5.r),
                                    ),
                                    child: Text(
                                      data[index].cdNm ?? '',
                                      style: CTS(
                                        color: isChecked[id] ?? false ? Colors.white : Colors.grey,
                                        fontSize: 12.sp,
                                        // overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              if (field.hasError)
                Column(
                  children: [
                    Gaps.v24,
                    FieldErrorText(
                      field: field,
                    ),
                  ],
                )
            ],
          ),
        ),
        Gaps.v24,
        _getTitle(
          widget.titles[3],
          false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: TextField(
            onChanged: (value) => setState(() {
              user.ocpCd = value;
            }),
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              enabledBorder: _inputBorder,
              focusedBorder: _inputBorder,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 18,
              ),
              hintText: '직급 또는 직무 입력',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Gaps.v16,
        _getTitle(
          widget.titles[4],
          false,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.w,
          ),
          child: AgencyProof(),
        ),
        Text(
          '※해당 기관 소속을 증명할 수 있는 명함 또는 신분증을 업로드해주세요.',
          style: CTS.medium(fontSize: 11, color: Palette.greyText_60)
        ),
        Gaps.v64,
      ],
    );
  }

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

  Widget _getTitle(String title, bool isRequired) => Row(
        children: [
          Text(
            title,
            style: CTS.medium(
              color: Colors.grey.shade600,
              fontSize: 13.sp,
            ),
          ),
          Text(
            isRequired ? '(필수)' : '',
            style: CTS.medium(
              fontSize: 13.sp,
              color: Palette.mainColor,
            ),
          ),
        ],
      );
}
