import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class PaitentCardItem extends StatelessWidget {
  PaitentCardItem(
      {super.key,
      required this.patientName,
      required this.patientSex,
      required this.patientAge,
      this.symbol,
      required this.color,
      this.hospital,
      this.tagList});
  String? hospital;
  List<String>? tagList;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      '$patientName ($patientSex/$patientAge세) ',
                      style: CTS.bold(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      // maxFontSize: 15,
                    ),
                    symbol != null
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 8.r,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.16),
                              borderRadius: BorderRadius.circular(
                                30.r,
                              ),
                            ),
                            child: Text(
                              symbol!,
                              style: CTS.bold(color: color, fontSize: 12),
                              maxLines: 1,
                              // maxFontSize: 18,
                            ),
                          )
                        : Container(),
                  ],
                ),
                hospital != null ? Gaps.v4 : Container(),
                hospital == null
                    ? Container()
                    : Text(
                        hospital ?? '알수없음',
                        style: CTS.medium(
                          color: Palette.black,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                      ),
                Gaps.v4,
                Text(
                  "대구광역시 북구 / 010-****-1234",
                  style: CTS(color: Colors.grey, fontSize: 12),
                  maxLines: 1,
                  // maxFontSize: 12,
                ),
                Text(
                  '2023년 2월 18일 15시 22분',
                  style: CTS(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  // maxFontSize: 18,
                ),
                tagList != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                        ),
                        child: Row(
                            children: List.generate(
                                tagList?.length ?? 0,
                                (index) => Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 1.h,
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
                                        '#${tagList?[index]}',
                                        style: CTS.bold(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ))),
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Color color;
  final String patientName, patientSex, patientAge;
  final String? symbol;
}
