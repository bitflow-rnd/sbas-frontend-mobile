import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/util.dart';

class PaitentCardItem extends StatelessWidget {
  const PaitentCardItem({
    super.key,
    required this.color,
    required this.model,
  });
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.r,
          horizontal: 16.r,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0x1a645c5c),
                offset: const Offset(0, 3),
                blurRadius: 12.r,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/patient.png",
                height: 36.h,
              ),
              SizedBox(
                width: 8.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${midMasking(model.ptNm)} (${model.gndr}/${formatRrno1(model.rrno1)}) ',
                        style: CTS.bold(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                      ),
                      // model.bedStatCd != null
                      //     ? Container(
                      //         padding: EdgeInsets.symmetric(
                      //           vertical: 4.h,
                      //           horizontal: 8.r,
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: color.withOpacity(0.16),
                      //           borderRadius: BorderRadius.circular(
                      //             30.r,
                      //           ),
                      //         ),
                      //         child: Text(
                      //           model.bedStatNm ?? '',
                      //           style: CTS.bold(color: color, fontSize: 12),
                      //           maxLines: 1,
                      //         ),
                      //       )
                      //     : Container(),
                    ],
                  ),
                  model.chrgInstId != null ? Gaps.v4 : Container(),
                  model.chrgInstId == null
                      ? Container()
                      : Text(
                          model.hospNm ?? '알수없음',
                          style: CTS.medium(
                            color: Palette.black,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                        ),
                  Gaps.v4,
                  Text(
                    '${model.dstr1CdNm} ${model.dstr2CdNm} / ${getPhoneFormat(model.mpno)}',
                    style: CTS(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                  ),
                  Text(
                    getDateTimeFormatFull(model.updtDttm ?? ''),
                    style: CTS(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                  ),
                  if (model.tagList != null && model.tagList!.isNotEmpty)
                    Center(
                      child: Container(
                        height: 33.h,
                        width: MediaQuery.of(context).size.width - 150.w,
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.tagList?.length ?? 0,
                          itemBuilder: (_, index) => Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.5.h,
                              horizontal: 6.w,
                            ),
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                4.r,
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: AutoSizeText(
                              '#${model.tagList?[index]}',
                              style: CTS.bold(
                                color: Colors.grey,
                              ),
                              maxFontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );

  String formatRrno1(String? rrno1) {
    if (rrno1?.length == 6) {
      return "${rrno1?.substring(0, 2)}.${rrno1?.substring(2, 4)}.${rrno1?.substring(4, 6)}";
    }
    return rrno1 ?? '';
  }

  final Patient model;
  final Color color;
}
