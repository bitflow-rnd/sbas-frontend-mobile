import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';

class AssignBedDetailPaitentInfo extends ConsumerWidget {
  AssignBedDetailPaitentInfo({
    super.key,
    required this.patient,
  });
  final List<String> list = [
    '환자이름',
    '주민등록번호',
    '주소',
    '사망여부',
    '국적',
    '휴대전화번호',
    '전화번호',
    '보호자이름',
    '직업',
    '기저질환',
  ];
  final Patient patient;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SingleChildScrollView(
          child: Column(
        children: [
          for (int i = 0; i < list.length; i++)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          list[i],
                          style: CTS(
                            color: Palette.greyText,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: i != 9
                            ? Text(
                                getConvertPatientInfo(i, patient),
                                style: CTS.medium(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // for(int j=0;j<patient.disease.length;j++)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Palette.greyText_20,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(13.5),
                                    ),
                                    child: Text(
                                      "고지혈증",
                                      // patient.disease[j].diseaseName,
                                      style: CTS(
                                          fontSize: 13,
                                          color: Palette.greyText_80),
                                      textAlign: TextAlign.end,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
                if (i == 1)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              '성별',
                              style: CTS(
                                color: Palette.greyText,
                                fontSize: 13,
                              ),
                            ),
                            Gaps.h10,
                            Text(
                              "남",
                              style: CTS.medium(
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Gaps.h32,
                        Row(
                          children: [
                            Text(
                              '나이',
                              style: CTS(
                                color: Palette.greyText,
                                fontSize: 13,
                              ),
                            ),
                            Gaps.h10,
                            Text(
                              "30세",
                              style: CTS.medium(
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      )),
    );
  }
}
