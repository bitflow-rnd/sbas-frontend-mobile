import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/patient/models/patient_model.dart';

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
                ? Text(
                    '신규 환자 등록',
                    style: CTS.bold(
                      fontSize: 16,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${patient?.ptNm}',
                          style: CTS.bold(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' [${getPatientInfo(patient!)}]',
                              style: CTS(
                                color: const Color(0xff333333),
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Gaps.v4,
                      (patient == null || patient?.undrDsesCdNm == null)
                          ? Container()
                          : Row(
                              children: [
                                for (int i = 0; i < patient!.undrDsesCdNm!.length; i++)
                                  Text(
                                    '#${patient?.undrDsesCdNm?[i]}',
                                    style: CTS(
                                      color: Palette.mainColor,
                                    ),
                                  ),
                              ],
                            ),
                    ],
                  ),
          ],
        ),
      );
  final Patient? patient;
}
