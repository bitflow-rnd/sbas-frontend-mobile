import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_detail_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_proof_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_region_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/patient_type_widget.dart';

class BelongAgency extends ConsumerStatefulWidget {
  BelongAgency({
    required this.patientTypes,
    required this.titles,
    super.key,
  });
  final List<bool> isSelectedTypes = [
    false,
    false,
    false,
    false,
  ];
  final List<String> titles, patientTypes;

  @override
  ConsumerState<BelongAgency> createState() => _BelongAgencyState();
}

class _BelongAgencyState extends ConsumerState<BelongAgency> {
  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(belongAgencyProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getTitle(
          widget.titles[0],
          true,
        ),
        watch.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          data: (data) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: AgencyRegion(
              agencyModel: data,
              inputDecoration: _inputDecoration,
            ),
          ),
        ),
        Gaps.v16,
        _getTitle(
          widget.titles[1],
          true,
        ),
        watch.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          data: (data) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: AgencyDetail(
              agencyModel: data,
              inputBorder: _inputBorder,
              inputDecoration: _inputDecoration,
            ),
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
        SizedBox(
          height: 128,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            itemCount: widget.patientTypes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 16,
              childAspectRatio: 2.15 / 1,
            ),
            itemBuilder: (context, index) => PatientType(
              title: widget.patientTypes[index],
              onChanged: (value) =>
                  setState(() => widget.isSelectedTypes[index] = !value),
              isSelected: widget.isSelectedTypes[index],
            ),
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
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
