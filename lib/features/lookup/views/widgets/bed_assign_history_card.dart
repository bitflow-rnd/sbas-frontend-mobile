import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';
import 'package:sbas/features/lookup/views/patient_bed_assign_detail_screen.dart';
import 'package:sbas/main.dart';

class BedAssignHistoryCardItem extends StatelessWidget {
  BedAssignHistoryCardItem(
      {super.key, required this.name, required this.disease, required this.timestamp, required this.count, this.hospital, this.tagList, required this.patient});
  String? hospital;
  Patient patient;
  List<String>? tagList;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientBedAssignDetailPage(
              patient: patient,
            ),
          ),
        );
      },
      child: Padding(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.h,
                  horizontal: 8.r,
                ),
                decoration: BoxDecoration(
                  color: Palette.mainColor.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(
                    30.r,
                  ),
                ),
                child: Text(
                  "  $count차  ",
                  style: CTS.bold(color: Palette.mainColor, fontSize: 12),
                  maxLines: 1,
                  // maxFontSize: 18,
                ),
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
                        '$name',
                        style: CTS.bold(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        // maxFontSize: 15,
                      ),
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
                    disease,
                    style: CTS(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    // maxFontSize: 12,
                  ),
                  Text(
                    timestamp,
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 8.r,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final String name, disease, timestamp, count;
}