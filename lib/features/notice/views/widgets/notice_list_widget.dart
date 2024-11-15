import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/authentication/blocs/user_detail_presenter.dart';
import 'package:sbas/features/notice/provider/notice_provider.dart';
import 'package:sbas/features/notice/models/notice_list_request_model.dart';
import 'package:sbas/features/notice/models/read_notice_request_model.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/features/notice/models/notice_model.dart';
import 'package:sbas/features/notice/views/public_notice_detail_screen.dart';

class NoticeListWidget extends ConsumerWidget {
  NoticeListWidget({
    super.key,
    required this.searchPeriod,
  });

  final String searchPeriod;

  final Map<String, String> periodMap = {
    '최근1개월': '1M',
    '최근3개월': '3M',
    '최근1년': '1Y'
  };

  String getPeriodCode(String period) {
    return periodMap[period] ?? '1M';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        String userId = ref.read(userDetailProvider.notifier).userId;
        NoticeListRequestModel request = NoticeListRequestModel(
          userId: userId,
          isActive: true,
          searchPeriod: getPeriodCode(searchPeriod),
        );

        ref.read(noticeProvider.notifier).getNoticeList(request);

        final noticeList = ref.watch(noticeListProvider);

        if (noticeList == null) {
          return const CircularProgressIndicator();
        }

        final notices = noticeList.items;

        List<Widget> noticeCards = notices.map((notice) {
          return alertCard(
            context,
            ref,
            notice,
            request,
          );
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),
            ...noticeCards,
          ],
        );
      },
    );

  }

  Widget alertCard(
    BuildContext context,
    WidgetRef ref,
    NoticeList notice,
    NoticeListRequestModel listRequest,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PublicNoticeDetailPage(
                        noticeId: notice.noticeId,
                        startNoticeDt: notice.startNoticeDt,
                      )));
          final userId = ref.read(userDetailProvider.notifier).userId;
          final request =
              ReadNoticeRequestModel(userId: userId, noticeId: notice.noticeId);
          ref.read(noticeProvider.notifier).readNotice(request);

          ref.read(noticeProvider.notifier).getNoticeList(listRequest);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1a645c5c),
                offset: Offset(0, 3),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notice.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CTS.bold(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      notice.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CTS(
                        color: const Color(0xff676a7a),
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xff676a7a).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            (() {
                              if (notice.noticeType == 'NOTC0001') {
                                return '일반';
                              } else if (notice.noticeType == 'NOTC0002') {
                                return '공지';
                              } else {
                                return 'NEWS';
                              }
                            })(),
                            style: CTS(
                              color: const Color(0xff676a7a),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          notice.startNoticeDt,
                          style: CTS(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        notice.hasFile
                            ? Padding(
                                padding: EdgeInsets.only(left: 6.r),
                                child: Image.asset(
                                    "assets/home/paper-clip-icon.png",
                                    width: 13.w,
                                    height: 13.h),
                              )
                            : Container(),
                        SizedBox(width: 8.w),
                        Text(
                          notice.isRead ? "" : "NEW",
                          style: CTS.medium(
                            color: const Color(0xff538ef5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Image.asset("assets/home/right_arrow.png"),
            ],
          ),
        ),
      ),
    );
  }
}
