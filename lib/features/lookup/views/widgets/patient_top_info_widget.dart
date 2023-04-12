import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';

class PatientTopInfo extends StatelessWidget {
  const PatientTopInfo({
    super.key,
    this.patient,
  });
  @override
  Widget build(BuildContext context) => Padding(
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
            patient == null
                ? const Text(
                    '신규 환자 등록',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${patient?.ptNm}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '[${getPatientInfo(patient!)}]',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.v4,
                      const Text(
                        '#temp',
                        style: TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      );
  final Patient? patient;
}
