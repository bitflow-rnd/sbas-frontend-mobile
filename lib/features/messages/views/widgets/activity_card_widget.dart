import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/messages/models/activity_history_model.dart';
import 'package:sbas/util.dart';
import 'package:sbas/constants/gaps.dart';

class ActivityCardWidget extends ConsumerWidget {
  final ActivityHistoryModel activity;

  const ActivityCardWidget({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = getColor(activity.activityDetail ?? '');

    print(activity.rgstDttm);

    return InkWell(
      onTap: () async {},
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.r,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  markTimeAgo(activity.rgstDttm),
                  style: CTS(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
                Gaps.v12,
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
                              '${activity.ptNm} (${activity.gndr}/${activity.rrno1})',
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
                                activity.activityDetail ?? '',
                                style: CTS.bold(
                                  color: color,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        //TODO
                        //tags 추가
                        // Container(
                        //   height: 32.h,
                        //   width: (MediaQuery.of(context).size.width / 2).w,
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: 6.h,
                        //   ),
                        //   child: ListView.separated(
                        //     separatorBuilder: (context, index) => Gaps.h4,
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: activity.tagList?.length ?? 0,
                        //     itemBuilder: (context, index) => Container(
                        //       padding: EdgeInsets.symmetric(
                        //         vertical: 2.5.h,
                        //         horizontal: 6.w,
                        //       ),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(
                        //           4.r,
                        //         ),
                        //         color: Colors.grey.shade100,
                        //       ),
                        //       child: AutoSizeText(
                        //         '#${model.tagList?[index]}',
                        //         style: CTS.bold(
                        //           color: Colors.grey,
                        //         ),
                        //         maxFontSize: 12,
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(String activityDetail) {
    switch(activityDetail) {
      case 'BAST0001':case 'BAST0008':
        return Colors.red;
      case 'BAST0007':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}