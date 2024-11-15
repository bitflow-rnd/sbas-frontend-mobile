import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/providers/loading_provider.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/model/assign_item_model.dart';
import 'package:sbas/features/assign/views/assign_bed_detail_screen.dart';
import 'package:sbas/features/lookup/blocs/patient_info_presenter.dart';
import 'package:sbas/features/lookup/presenters/patient_disease_info_presenter.dart';
import 'package:sbas/features/lookup/presenters/patient_transfer_info_presenter.dart';
import 'package:sbas/util.dart';

class AsgnCardItem extends ConsumerWidget {
  const AsgnCardItem({
    super.key,
    required this.model,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        ref.watch(loadingProvider.notifier).show();
        final patient =
            await ref.read(patientInfoProvider.notifier).getAsync(model.ptId);
        final diseaseInfo = await ref
            .read(patientDiseaseInfoProvider.notifier)
            .getAsync(model.ptId);
        final orignInfo = await ref
            .read(patientTransferInfoProvider.notifier)
            .getTransInfo(model.ptId, model.bdasSeq ?? -1);

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignBedDetailScreen(
                patient: patient,
                assignItem: model,
                diseaseInfo: diseaseInfo,
                transferInfo: orignInfo),
            )
          );
          ref.watch(loadingProvider.notifier).hide();
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
                          '${model.ptNm} (${model.gndr}/${model.rrno1})',
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
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2).w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (model.chrgInstNm != null &&
                              model.chrgInstNm != '')
                            Column(
                              children: [
                                Gaps.v4,
                                Text(
                                  model.chrgInstNm ?? '',
                                  style: CTS.medium(
                                      color: Palette.black, fontSize: 11.sp),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          if (model.diagNm != null && model.diagNm != '')
                            Column(children: [
                              Gaps.v4,
                              Text(
                                model.diagNm ?? '',
                                style: CTS(color: Colors.grey, fontSize: 11.sp),
                                maxLines: 1,
                              ),
                            ]),
                          if (model.bascAddr != null && model.bascAddr != '')
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  Gaps.v4,
                                  Text(
                                    model.bascAddr ?? '',
                                    style: CTS(
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
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
              top: 28,
              right: 8,
              child: Text(
                markTimeAgo(model.updtDttm),
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
  }

  final Color color;
  final AssignItemModel model;
}
