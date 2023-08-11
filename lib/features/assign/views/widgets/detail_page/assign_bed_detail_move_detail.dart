import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class AssignBedMoveDetialInfo extends ConsumerWidget {
  const AssignBedMoveDetialInfo({super.key, this.type});
  final String? type;
  final String message =
      "메시지";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String detailDest = '대구 북구 호암로 51 래미안아파트 113동 501호';
    List<String> list = [];
    if (type == "병원-집") {
      list = [
        '환자 출발지',
        '배정 요청 지역',
        '보호자 1 연락처',
        '보호자 2 연락처',
        '메시지',
      ];
    } else {
      list = [
        '환자 출발지',
        '배정 요청 지역',
        '진료과',
        '담당의',
        '전화번호',
        '원내배정여부',
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
                      const Spacer(),
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
                  i == 0
                      ? Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Text(
                            '대구 북구 호암로 51 래미안아파트 113동 501호',
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
    String text = '';
    if (type == "병원-집") {
      text = "Data has to be here";
      switch (index) {
        case 0:
          text = "자택";
          break;
        case 1:
          text = '대구광역시';
          break;
        case 2:
          text = "010-2323-2323";
          break;
        case 3:
          text = "010-2323-2323";
          break;
        case 4:
          text = "";
          break;
      }
      return text;
    } else {
      switch (index) {
        case 0:
          text = "자택";
          break;
        case 1:
          text = '대구광역시';
          break;
        case 2:
          text = "감염내과";
          break;
        case 3:
          text = "권승구";
          break;
        case 4:
          text = "022-2222-2222";
          break;
        case 5:
          text = "전원요청";
          break;
        case 6:
          text = "";
          break;
      }
      return text;
    }
  }
}
