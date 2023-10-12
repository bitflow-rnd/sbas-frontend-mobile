import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/features/authentication/blocs/user_detail_presenter.dart';
import 'package:sbas/features/notice/blocs/notice_presenter.dart';
import 'package:sbas/features/notice/models/notice_list_request_model.dart';

import '../../../common/bitflow_theme.dart';
import 'public_notice_detail_screen.dart';
import '../models/notice_list_model.dart';

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
    String userId = ref.read(userDetailProvider.notifier).userId;
    NoticeListRequestModel request = NoticeListRequestModel(
        userId: userId,
        isActive: true,
        searchPeriod: getPeriodCode(searchPeriod));

    final noticeList = ref.read(noticePresenter.notifier).getNoticeList(request);

    return FutureBuilder(
      future: noticeList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Text('No data found');
          }

          final notices = (snapshot.data as NoticeListModel).items;

          List<Widget> noticeCards = notices.map((notice) {
            return alertCard(
              context,
              notice.noticeId,
              notice.title,
              notice.content,
              notice.noticeType,
              notice.startNoticeDt,
              notice.isRead,
              notice.hasFile,
            );
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.h),
              ...noticeCards,
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget alertCard(BuildContext context, String noticeId, String title, String body, String type,
      String datetime, bool isRead, bool hasFile) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PublicNoticeDetailPage(noticeId: noticeId,)));
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
                            title,
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
                      body,
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
                              if (type == 'B') {
                                return '일반';
                              } else if (type == 'N') {
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
                          datetime,
                          style: CTS(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        hasFile
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
                          isRead ? "" : "NEW",
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
