import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/assign_bed_detail_screen.dart';
import 'package:sbas/features/lookup/models/patient_model.dart';

class CardItem extends StatelessWidget {
  CardItem({
    super.key,
    required this.patient,
    required this.color,
    this.hospital,
  });
  Patient patient;
  String? hospital;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.r,
        horizontal: 16.r,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignBedDetailScreen(patient: patient),
              ));
        },
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
          child: Stack(
            children: [
              Row(
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
                            '${patient.ptNm} (${patient.getSex()}/${patient.getAge()}세) ',
                            style: CTS.bold(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            // maxFontSize: 15,
                          ),
                          Container(
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
                              patient.bedStatNm ?? '', //symbol
                              style: CTS.bold(color: color, fontSize: 12),
                              maxLines: 1,
                              // maxFontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      hospital != null ? Gaps.v4 : Container(),
                      hospital == null
                          ? Container()
                          : Text(
                              hospital ?? '병원명',
                              style: CTS.medium(
                                color: Palette.black,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                      Gaps.v4,
                      Text(
                        '코로나바이러스 감염증-19',
                        style: CTS(color: Colors.grey, fontSize: 12),
                        maxLines: 1,
                        // maxFontSize: 12,
                      ),
                      Text(
                        '서울특별시 구로구 구로동 디지털로 86가길 32',
                        style: CTS(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        // maxFontSize: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 6.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4.r,
                                ),
                                color: Colors.grey.shade100,
                              ),
                              child: AutoSizeText(
                                '#임산부',
                                style: CTS.bold(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 2,
                right: 4,
                child: Text(
                  '3시간전',
                  style: CTS(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                  // maxLines: 1,
                  // maxFontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Color color;
}
