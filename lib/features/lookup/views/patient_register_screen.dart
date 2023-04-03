import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/views/widgets/patient_reg_top_nav_widget.dart';

class PatientRegScreen extends ConsumerWidget {
  const PatientRegScreen({
    required this.newPatient,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Bitflow.getAppBar(
        '환자 등록',
        true,
        0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/patient.png',
                  height: 42,
                ),
                Gaps.h8,
                newPatient
                    ? const Text(
                        '신규 환자 등록',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      )
                    : getPatientInfo(),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: PatientRegTopNav(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '역학조사서 업로드(선택)',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/auth_group/camera_location.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  text: '취소 ',
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: width * 0.5,
                child: BottomSubmitBtn(
                  text: '다음',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getPatientInfo() {
    return const SizedBox();
  }

  final bool newPatient;
}
