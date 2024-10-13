import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/modal_tab/assign_bed_find_screen.dart';
import 'package:sbas/features/messages/models/user_detail_model.dart';

class UserCardItem extends ConsumerStatefulWidget {
  const UserCardItem({
    super.key,
    required this.model,
  });

  final UserDetailModel model;
  @override
  ConsumerState<UserCardItem> createState() => _UserCardItemState();
}

class _UserCardItemState extends ConsumerState<UserCardItem> {
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
        child: GestureDetector(
          onTap: () {
            ref.watch(selectedItemsProvider.notifier).state.add(widget.model.id!);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/message/doctor_icon.png",
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
                        '${widget.model.userNm} ',
                        style: CTS.bold(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  Gaps.v4,
                  Text(
                    '${widget.model.instTypeCdNm} ${widget.model.instNm}',
                    style: CTS.medium(
                      color: Palette.black,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                  ),
                  Gaps.v4,
                  Text(
                    '${widget.model.dutyDstr1CdNm} ${widget.model.dutyDstr2CdNm} ${widget.model.jobCdNm}',
                    style: CTS(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                  ),
                  // if (model.tagList != null && model.tagList!.isNotEmpty)
                  //   Center(
                  //     child: Container(
                  //       height: 33.h,
                  //       width: MediaQuery.of(context).size.width - 150.w,
                  //       padding: EdgeInsets.symmetric(
                  //         vertical: 6.h,
                  //       ),
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         itemCount: model.tagList?.length ?? 0,
                  //         itemBuilder: (_, index) => Container(
                  //           padding: EdgeInsets.symmetric(
                  //             vertical: 2.5.h,
                  //             horizontal: 6.w,
                  //           ),
                  //           margin: EdgeInsets.only(right: 8.w),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(
                  //               4.r,
                  //             ),
                  //             color: Colors.grey.shade100,
                  //           ),
                  //           child: AutoSizeText(
                  //             '#${model.tagList?[index]}',
                  //             style: CTS.bold(
                  //               color: Colors.grey,
                  //             ),
                  //             maxFontSize: 12,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              const Spacer(),
              Container(
                height: 24.h,
                width: 24.h,
                decoration: BoxDecoration(
                    color: ref.watch(selectedItemsProvider.notifier).state.contains(widget.model.id)
                        ? Palette.mainColor
                        : Palette.white,
                    borderRadius: BorderRadius.circular(4.r),
                    border: ref.watch(selectedItemsProvider.notifier).state.contains(widget.model.id)
                        ? null
                        : Border.all(color: Palette.greyText_20, width: 1)),
                child: ref.watch(selectedItemsProvider.notifier).state.contains(widget.model.id)
                    ? Icon(
                      Icons.check,
                      color: Palette.white,
                      size: 16.h,
                    ) : Container()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
