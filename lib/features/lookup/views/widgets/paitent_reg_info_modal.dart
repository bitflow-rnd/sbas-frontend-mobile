import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class PatientRegInfoModal {
  showModal1(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "역학조사서 파일을 기반으로\n환자정보를 자동입력 하였습니다.\n내용을 확인해주세요.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          imageHeight: 44.h,
        ));
  }

  showModal2(context, paitentInfo) {
    return Common.showModal(
        context,
        IntrinsicWidth(
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
                              style: CTS.bold(color: Palette.black, fontSize: 14, height: 1.5),
                            ).c,
                          ),
                        ),
                      ],
                    ),
                    modal2frag(true, "이름 : 김억자 (남/88세)"),
                    modal2frag(true, "주민등록번호 : 780412-1******"),
                    modal2frag(true, "주소 : 대구시 북구"),
                    modal2frag(false, "연락처 : 010-1234-5678"),
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
                                      color: const Color(0xff676a7a),
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context, "close");
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 9.r),
                                      child: Text(
                                        "닫기",
                                        style: CTS(color: const Color(0xff676a7a), fontSize: 14),
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
                                      Navigator.pop(context, "update");
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 9.r),
                                      child: Text(
                                        "업데이트",
                                        style: CTS(color: Palette.mainColor, fontSize: 14),
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
                                      Navigator.pop(context, "new");
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 9.r),
                                      child: Text(
                                        "새로등록",
                                        style: CTS(color: Palette.white, fontSize: 14),
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
              color: Color(isCorrect ? 0xff538ef5 : 0xff676a7a).withOpacity(0.12),
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

  showModal3(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "등록된 환자의 이름, 주민등록번호가\n역학조사서의 내용과 다릅니다.\n내용을 확인해주세요.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          imageHeight: 44.h,
        ));
  }

  showModal4(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "소속 기관의 승인자에게\n승인 요청을 보냅니다.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          button1Function: () {
            Navigator.pop(context);
          },
          imageHeight: 44.h,
        ));
  }

  showModal5(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "소속 기관의 승인자가 없습니다.\n시스템관리자에게\n승인요청을 보냅니다.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          button1Function: () {
            Navigator.pop(context);
          },
          imageHeight: 44.h,
        ));
  }

  showModal6(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "승인된 사용자입니다.\n지금부터 로그인 가능합니다.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          button1Function: () {
            Navigator.pop(context);
          },
          imageHeight: 44.h,
        ));
  }
}
