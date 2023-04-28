import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_detail_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_proof_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_region_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/patient_type_widget.dart';
import 'package:sbas/constants/palette.dart';

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
  Widget build(BuildContext context) => Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: AgencyProof(),
          ),
          Gaps.v16,
          _getTitle(
            widget.titles[3],
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
                  height: 128,
                  child: ref.watch(belongAgencyProvider).when(
                        loading: () => const SBASProgressIndicator(),
                        error: (error, stackTrace) => Center(
                          child: Text(
                            error.toString(),
                            style: const TextStyle(
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
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 16,
                            childAspectRatio: 2.15 / 1,
                          ),
                          itemBuilder: (context, index) {
                            final id = data[index].id!.cdId!;

                            return PatientType(
                              id: id,
                              title: data[index].cdNm ?? '',
                              onChanged: (value) => setState(() {
                                ref.read(isCheckedProvider)[id] = !value;

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
        ],
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
  Widget _getTitle(String title, bool isRequired) => Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          Text(
            isRequired ? '*' : '',
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      );
}
