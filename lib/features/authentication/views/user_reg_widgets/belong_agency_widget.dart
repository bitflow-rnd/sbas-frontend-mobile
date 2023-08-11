import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_detail_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_proof_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_region_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/patient_type_widget.dart';
import 'package:sbas/constants/palette.dart';

import '../../blocs/user_reg_bloc.dart';

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
  final bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(regUserProvider);
    final isCheckedMap = ref.watch(isCheckedProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     _getTitle(
        //       "소속기관 유형",
        //       true,
        //     ),
        //     Spacer(),
        //     Checkbox(
        //       activeColor: Palette.mainColor,
        //       visualDensity: VisualDensity.compact,
        //       value: _isSelected,
        //       onChanged: (bool? newValue) {
        //         setState(() {
        //           _isSelected = newValue ?? false;
        //         });
        //       },
        //       checkColor: Colors.white,
        //       tristate: false,
        //     ),
        //     Text(
        //       '조회전용',
        //       style: CTS(
        //         color: Palette.greyText,
        //         fontSize: 11,
        //       ),
        //     ),
        //   ],
        // ),
        // Gaps.v10,
        // Row(
        //   children: [
        //     selectorWidget("의료진", true),
        //     selectorWidget("병상배정반 ", false),
        //     selectorWidget("보건소", false),
        //     selectorWidget("전산", false),
        //   ],
        // ),
        Gaps.v4,
        _getTitle(
          widget.titles[0],
          true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: AgencyRegion(
            inputDecoration: _inputDecoration,
          ),
        ),
        Gaps.v16,
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
            inputDecoration: _inputDecoration,
          ),
        ),
        Gaps.v16,
        _getTitle(
          widget.titles[2],
          false,
        ),
        FormField(
          autovalidateMode: AutovalidateMode.always,
          initialValue: ref.watch(isCheckedProvider).containsValue(true),
          validator: (value) => value == null || !value ? '※담당 환자 유형을 1개 이상 선택해주세요.' : null,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 96,
                child: ref.watch(belongAgencyProvider).when(
                  loading: () => const SBASProgressIndicator(),
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                      style: CTS(
                        color: Palette.mainColor,
                      ),
                    ),
                  ),
                  data: (data) => GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    itemCount: data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.15 / 1,
                    ),
                    itemBuilder: (context, index) {
                      final id = data[index].cdId!;

                      return PatientType(
                        id: id,
                        title: data[index].cdNm ?? '',
                        onChanged: (value) => setState(() {
                          ref.read(isCheckedProvider)[id] = !value;

                          var checkedKeys = isCheckedMap.entries
                              .where((entry) => entry.value == true).map((entry) => entry.key);
                          user.ptTypeCd = checkedKeys.join(";");

                          field.didChange(ref.watch(isCheckedProvider).containsValue(true));
                        }),
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              if (field.hasError)
                FieldErrorText(
                  field: field,
                )
            ],
          ),
        ),
        Gaps.v16,
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
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: AgencyProof(),
        ),
        Gaps.v52,
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

  InputDecoration get _inputDecoration => InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        contentPadding: const EdgeInsets.all(0),
      );
  Widget _getTitle(String title, bool isRequired) => Row(
        children: [
          Text(
            title,
            style: CTS.bold(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          Text(
            isRequired ? '(필수)' : '',
            style: CTS.bold(
              fontSize: 13,
              color: Palette.mainColor,
            ),
          ),
        ],
      );
  Widget selectorWidget(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? Palette.mainColor : const Color(0xffecedef).withOpacity(0.6),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: CTS.medium(
            color: isSelected ? Colors.white : Palette.greyText_60,
            fontSize: 11,
          ),
        ).c,
      ),
    );
  }
}
