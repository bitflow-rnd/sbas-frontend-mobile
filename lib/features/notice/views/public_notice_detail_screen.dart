import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/notice/blocs/notice_presenter.dart';

class PublicNoticeDetailPage extends ConsumerWidget {
  const PublicNoticeDetailPage({
    super.key,
    required this.noticeId,
  });

  final String noticeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final noticeDetail = ref.read(noticePresenter.notifier).getNoticeDetail(noticeId);

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar("공지사항", true, 0),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 1.h, color: Palette.greyText.withOpacity(0.2)),
              alertDetailCard(
                  "제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.제목 1줄로 표시됩니다.",
                  "내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및..내용 1줄 출력 및 말줄임표… 내용 1줄 출력 및...",
                  "공지",
                  "2023.03.03",
                  false,
                  true),
            ],
          ),
        ),
      ),
    );
  }

  Widget alertDetailCard(String title, String body, String type,
      String datetime, bool isRead, bool hasFile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Color(0xff676a7a).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  type,
                  style: CTS(
                    color: Color(0xff676a7a),
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
              SizedBox(width: 8.w),
              Text(
                isRead ? "NEW" : "",
                style: CTS.medium(
                  color: Color(0xff538ef5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          Text(
            title,
            style: CTS.medium(
              color: Colors.black,
              fontSize: 15,
              height: 1.6,
            ),
          ),
          Container(
              height: 1.h,
              margin: EdgeInsets.symmetric(vertical: 16.h),
              color: Palette.greyText.withOpacity(0.2)),
          Text(
            '내용을 출력합니다. 내용을 출력합니다. 내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.내용을 출력합니다.',
            style: CTS(
              color: Palette.greyText_80,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  margin: EdgeInsets.only(bottom: 2.h, top: 20.h),
                  decoration: BoxDecoration(
                    color: Palette.greyText.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      hasFile
                          ? Padding(
                              padding: EdgeInsets.only(right: 6.r),
                              child: Image.asset(
                                  "assets/home/paper-clip-icon.png",
                                  width: 13.w,
                                  height: 13.h),
                            )
                          : Container(),
                      Text(
                        "첨부파일명.확장자",
                        style: CTS(
                          color: Palette.mainColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Palette.greyText.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      hasFile
                          ? Padding(
                              padding: EdgeInsets.only(right: 6.r),
                              child: Image.asset(
                                  "assets/home/paper-clip-icon.png",
                                  width: 13.w,
                                  height: 13.h),
                            )
                          : Container(),
                      Text(
                        "첨부파일명.확장자",
                        style: CTS(
                          color: Palette.mainColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Image.asset("assets/testImg.png"),
        ],
      ),
    );
  }
}
