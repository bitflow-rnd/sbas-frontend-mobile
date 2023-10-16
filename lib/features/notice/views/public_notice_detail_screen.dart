import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_attc_model.dart';
import 'package:sbas/common/repos/file_repo.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/notice/blocs/notice_presenter.dart';

class PublicNoticeDetailPage extends ConsumerWidget {
  const PublicNoticeDetailPage({
    super.key,
    required this.noticeId,
    required this.startNoticeDt,
  });

  final String noticeId;
  final String startNoticeDt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeDetail =
        ref.read(noticePresenter.notifier).getNoticeDetail(noticeId);

    return FutureBuilder(
        future: noticeDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final detail = snapshot.data;

            return Scaffold(
              backgroundColor: Palette.white,
              appBar: Bitflow.getAppBar("공지사항", true, 0),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 1.h,
                          color: Palette.greyText.withOpacity(0.2)),
                      alertDetailCard(
                          ref,
                          detail?.title ?? '',
                          detail?.content ?? '',
                          detail?.noticeType ?? '',
                          startNoticeDt,
                          detail?.attcGrpId ?? ''),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget alertDetailCard(WidgetRef ref, String title, String body, String type,
      String datetime, String attcGrpId) {
    final hasFile = attcGrpId != '';
    Future<List<BaseAttcModel>>? fileList;
    if (hasFile) {
      fileList = ref.read(fileRepoProvider).getFileList(attcGrpId);
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
              SizedBox(width: 8.w),
              // Text(
              //   isRead ? "NEW" : "",
              //   style: CTS.medium(
              //     color: const Color(0xff538ef5),
              //     fontSize: 12,
              //   ),
              // ),
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
            body,
            style: CTS(
              color: Palette.greyText_80,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          hasFile
              ? FutureBuilder(
                  future: fileList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final fileList = snapshot.data;
                      List<String> imageList = [];

                      for (var file in fileList!) {
                        if (file.fileTypeCd == 'FLTP0001') {
                          imageList.add(
                              "http://dev.${file.loclPath.substring(11)}/${file.fileNm}");
                        }
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return const Text('No data found');
                      }

                      return Column(children: [
                        Column(
                          children: [
                            ...fileList.map((file) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(8.r),
                                      margin: EdgeInsets.only(
                                          bottom: 2.h, top: 10.h),
                                      decoration: BoxDecoration(
                                        color:
                                            Palette.greyText.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 6.r),
                                            child: Image.asset(
                                                "assets/home/paper-clip-icon.png",
                                                width: 13.w,
                                                height: 13.h),
                                          ),
                                          GestureDetector(
                                            onTap: (() => {
                                              print('${file.attcGrpId}${file.attcId}'),
                                              ref.read(fileRepoProvider).downloadFile(file.attcGrpId, file.attcId)
                                            }),
                                            child: Text(
                                              file.fileNm,
                                              style: CTS(
                                                color: Palette.mainColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            SizedBox(height: 20.h),
                            ...imageList
                                .map((url) => Image.network(url))
                                .toList()
                          ],
                        )
                      ]);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}