import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/lookup/presenters/patient_lookup_provider.dart';
import 'package:sbas/features/patient/models/patient_model.dart';

class AssignBedDetailPatientInfo extends ConsumerWidget {
  AssignBedDetailPatientInfo({
    super.key,
    required this.patient,
  });
  final Patient patient;
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.read(assignBedProvider.notifier).getTagList(patient.ptId);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < list.length; i++)
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.h,
                      vertical: 12.w,
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
                                  style: CTS.medium(fontSize: 13),
                                  textAlign: TextAlign.end,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                  ),
                                  height: 26.h,
                                  child: ListView.separated(
                                    separatorBuilder: (_, index) => Gaps.h4,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tags?.length ?? 0,
                                    itemBuilder: (_, index) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Palette.greyText_20,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(13.5.r),
                                      ),
                                      child: Text(
                                        tags?[index] ?? '',
                                        style: CTS(
                                          fontSize: 13.sp,
                                          color: Palette.greyText_80,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
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
                                patient.gndr ?? '',
                                style: CTS.medium(fontSize: 13),
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
                                '${patient.age}세',
                                style: CTS.medium(fontSize: 13),
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
        ),
      ),
    );
  }
}
