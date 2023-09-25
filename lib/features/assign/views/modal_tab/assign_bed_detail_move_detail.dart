import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/widgets/detail_page/assign_bed_detail_disease_info.dart';
import 'package:sbas/features/lookup/models/origin_info_model.dart';

class AssignBedMoveDetialInfo extends ConsumerWidget {
  const AssignBedMoveDetialInfo({
    super.key,
    this.type,
    this.ptId,
    required this.transferInfo,
  });
  final String? type;
  final String message = "메시지";
  final OriginInfoModel transferInfo;
  final String? ptId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> list = [];
    if (transferInfo.dprtDstrTypeCd == "DPTP0001") {
      //DPTP0001: 자택 ,  DPTP9992: 병원 DPTP0003: 기타.
      list = [
        '환자 출발지',
        '배정 요청 지역',
        '보호자 1 연락처',
        '보호자 2 연락처',
        '메시지',
      ];
    } else if (transferInfo.dprtDstrTypeCd == "DPTP0002") {
      list = [
        '환자 출발지',
        '배정 요청 지역',
        '진료과',
        '담당의',
        '전화번호',
        '원내배정여부',
        '메시지',
      ];
    } else {
      list = [
        '환자 출발지',
        '배정 요청 지역',
        '메시지',
      ];
    }
    return Expanded(
      child: SingleChildScrollView(
          child: Column(
        children: [
          //담당보건소~비고
          Gaps.v20,
          for (int i = 0; i < list.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        list[i],
                        style: CTS(
                          color: Palette.greyText,
                          fontSize: 13,
                        ),
                      ),
                      Spacer(),
                      Text(
                        _getListValue_1(i),
                        style: CTS.medium(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  i == 0 && (transferInfo.dprtDstrBascAddr == null && transferInfo.dprtDstrDetlAddr == null) == false
                      ? Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Text(
                            "${transferInfo.dprtDstrBascAddr ?? ""}" " ${(transferInfo.dprtDstrDetlAddr ?? " ")}",
                            textAlign: TextAlign.end,
                            style: CTS(
                              color: Palette.greyText,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: CTS(color: Palette.mainColor, fontSize: 12),
                    maxLines: 22,
                  ),
                )
              ],
            ),
          ),
          Gaps.v32,
        ],
      )),
    );
  }

  String _getListValue_1(int index) {
    if (transferInfo.dprtDstrTypeCd == "DPTP0001") {
      // '환자 출발지',
      // '배정 요청 지역',
      // '보호자 1 연락처',
      // '보호자 2 연락처',
      // '메시지',
      switch (index) {
        case 0:
          return "자택";
        case 1:
          return transferInfo.reqDstr1CdNm.getText;
        case 2:
          return transferInfo.nok1Telno.getText;
        case 3:
          return transferInfo.nok2Telno.getText;
        case 4:
          return transferInfo.msg.getText;
      }
    } else if (transferInfo.dprtDstrTypeCd == "DPTP0002") {
      switch (index) {
        //  '환자 출발지',
        // '배정 요청 지역',
        // '진료과',
        // '담당의',
        // '전화번호',
        // '원내배정여부',
        // '메시지',
        case 0:
          return "병원";
        case 1:
          return transferInfo.reqDstr1CdNm.getText;
        case 2:
          return transferInfo.deptNm.getText;
        case 3:
          return transferInfo.spclNm.getText;
        case 4:
          return transferInfo.chrgTelno.getText;
        case 5:
          return (transferInfo.inhpAsgnYn ?? "N") == "Y" ? "원내배정" : "전원요청";
        case 6:
          return transferInfo.msg.getText;
      }
    } else if (transferInfo.dprtDstrTypeCd == "DPTP0003") {
      switch (index) {
        case 0:
          return "기타";
        case 1:
          return transferInfo.reqDstr1CdNm.getText;

        case 2:
          return transferInfo.msg.getText;
      }
    }
    return "";
  }
}
