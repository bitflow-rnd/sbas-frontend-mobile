import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/hospital_bed_request_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';

patientDuplicateCheckModal(context, PatientCheckResponse oldPatient,
    PatientRegInfoModel newPatient, WidgetRef ref) {
  final order = ref.watch(orderOfRequestProvider);
  return Common.showModal(
      context,
      IntrinsicWidth(
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r)),
          backgroundColor: Palette.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.r),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  Container(
                    margin: EdgeInsets.only(top: 24.h),
                    height: 44.h,
                    child: Center(
                      child: Image.asset(
                        "assets/auth_group/modal_check.png",
                        width: 44.h,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.r, bottom: 12.r),
                          child: Text(
                            "환자정보 존재",
                            textAlign: TextAlign.center,
                            style: CTS.bold(
                                color: Palette.black,
                                fontSize: 14,
                                height: 1.5),
                          ).c,
                        ),
                      ),
                    ],
                  ),
                  modal2frag(oldPatient.ptNm == newPatient.ptNm,
                      "이름 : ${oldPatient.ptNm}"),
                  modal2frag(
                    oldPatient.rrno1 == newPatient.rrno1 &&
                        oldPatient.rrno2 == newPatient.rrno2,
                    "주민등록번호 : ${oldPatient.rrno1}-${oldPatient.rrno2}",
                  ),
                  modal2frag(
                    oldPatient.dstr1Cd == newPatient.dstr1Cd &&
                        oldPatient.dstr2Cd == newPatient.dstr2Cd,
                    "주소 : ${oldPatient.dstr1CdNm} ${oldPatient.dstr2CdNm}",
                  ),
                  modal2frag(oldPatient.telno == newPatient.telno,
                      "연락처 : ${oldPatient.telno ?? "-"}"),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.r),
                    child: Text(
                      "※ 동명이인 여부를 확인해주세요.",
                      textAlign: TextAlign.start,
                      style: CTS(color: Palette.mainColor, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.r),
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Material(
                              color: Palette.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xff676a7a),
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context, "close");
                                  },
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 9.r),
                                    child: Text(
                                      "닫기",
                                      style: CTS(
                                          color: Color(0xff676a7a),
                                          fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ).c,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Palette.mainColor,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .read(patientRegProvider.notifier)
                                        .updatePatient(
                                        oldPatient.ptId, context);
                                    Navigator.pop(context);
                                    ref
                                        .read(orderOfRequestProvider.notifier)
                                        .update((state) => order + 1);
                                  },
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 9.r),
                                    child: Text(
                                      "업데이트",
                                      style: CTS(
                                          color: Palette.mainColor,
                                          fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ).c,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.mainColor,
                                border: Border.all(
                                  color: Palette.mainColor,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Material(
                                color: Palette.mainColor,
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .read(patientRegProvider.notifier)
                                        .registry(newPatient.ptId);
                                    Navigator.pop(context);
                                    ref
                                        .read(orderOfRequestProvider.notifier)
                                        .update((state) => order + 1);
                                  },
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 9.r),
                                    child: Text(
                                      "새로등록",
                                      style: CTS(
                                          color: Palette.white, fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ).c,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
}

modal2frag(bool isCorrect, String detail) {
  return Container(
    margin: EdgeInsets.only(top: 9.h),
    child: Row(
      children: [
        Container(
          width: 44.w,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color:
            Color(isCorrect ? 0xff538ef5 : 0xff676a7a).withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            isCorrect ? '일치' : "불일치",
            style: CTS(
              color: Color(isCorrect ? 0xff538ef5 : 0xff676a7a),
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ).c,
        ),
        Gaps.h8,
        Text(
          detail,
          style: CTS(color: Colors.black, fontSize: 12),
        ),
      ],
    ),
  );
}