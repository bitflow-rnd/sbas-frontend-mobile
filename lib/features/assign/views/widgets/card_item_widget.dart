import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/views/assign_bed_detail_screen.dart';
import 'package:sbas/features/lookup/blocs/patient_info_presenter.dart';
import 'package:sbas/features/lookup/presenters/patient_disease_info_presenter.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';

class AsgnCardItem extends ConsumerWidget {
  const AsgnCardItem({
    super.key,
    required this.model,
    required this.color,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
        onTap: () async {
          final patient = await ref.read(patientInfoProvider.notifier).getAsync(model.ptId);
          final diseaseInfo = await ref.read(patientDiseaseInfoProvider.notifier).getAsync(model.ptId);

          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignBedDetailScreen(
                  patient: patient,
                  assignItem: model,
                  diseaseInfo: diseaseInfo,
                ),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.r,
            horizontal: 20.r,
          ),
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
                            '${model.ptNm} (${model.gndr}/${model.age}세) ',
                            style: CTS.bold(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            maxLines: 1,
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
                              model.bedStatCdNm ?? '',
                              style: CTS.bold(
                                color: color,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      model.chrgInstNm != null && model.chrgInstNm != '' ? Gaps.v4 : Container(),
                      model.chrgInstNm == null || model.chrgInstNm == ''
                          ? Container()
                          : Text(
                              model.chrgInstNm ?? '',
                              style: CTS.medium(
                                color: Palette.black,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                      if (model.diagNm != null && model.diagNm != '') Gaps.v4,
                      if (model.diagNm != null && model.diagNm != '')
                        Text(
                          model.diagNm ?? '',
                          style: CTS(color: Colors.grey, fontSize: 12),
                          maxLines: 1,
                        ),
                      Text(
                        model.bascAddr ?? '',
                        style: CTS(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                      ),
                      Container(
                        height: 32.h,
                        width: (MediaQuery.of(context).size.width / 2).w,
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Gaps.h4,
                          scrollDirection: Axis.horizontal,
                          itemCount: model.tagList?.length ?? 0,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.5.h,
                              horizontal: 6.w,
                            ),
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
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 2,
                right: 4,
                child: Text(
                  _markTimeAgo(model.updtDttm),
                  style: CTS(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  String _markTimeAgo(String? dtStr) {
    if (dtStr != null) {
      final dt = DateTime.tryParse(dtStr);

      if (dt != null) {
        final difference = DateTime.now().difference(dt);

        if (difference.inDays > 0) {
          return '${difference.inDays}일전';
        }
        if (difference.inHours > 0) {
          return '${difference.inHours}시간전';
        }
        if (difference.inMinutes > 0) {
          return '${difference.inMinutes}분전';
        }
        if (difference.inSeconds > 0) {
          return '${difference.inSeconds}초전';
        }
      }
    }
    return '';
  }

  final Color color;
  final AssignItemModel model;
}
