import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/util.dart' as util;
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_attc_model.dart';
import 'package:sbas/common/repos/file_repo.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

Row myChatPhotoAttachedWidget(
  TalkMsgModel input,
  ScrollController scrollController,
) {
  final fileRepository = FileRepository();

  Future<List<BaseAttcModel>> getFileList() {
    return fileRepository.getFileList(input.attcId!);
  }

  Future<void> downloadFile(
      String attcGrpId, String attcId, String fileNm) async {
    try {
      await fileRepository.downloadPublicImageFile(attcGrpId, attcId, fileNm);

      util.showToast("파일 다운로드 성공");
    } catch (e) {
      util.showToast("파일 다운로드 실패");
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        textAlign: TextAlign.right,
        formatDateTime(input.updtDttm!),
        style: CTS(fontSize: 12, color: Colors.grey),
      ),
      Gaps.h5,
      Flexible(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 310,
          ),
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8)),
              color: const Color(0xfffff700).withOpacity(0.333),
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: getFileList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Wrap(
                        spacing: 0.8,
                        runSpacing: 0.8,
                        children: snapshot.data!
                            .map((file) => GestureDetector(
                                  child: Image.network(
                                    "http://dev.smartbas.org/${file.uriPath}/${file.fileNm}",
                                    height: 150.h,
                                    width: 100.w,
                                  ),
                                  onTap: () => {
                                    downloadFile(
                                      file.attcGrpId,
                                      file.attcId,
                                      file.fileNm,
                                    )
                                  },
                                ))
                            .toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Image.asset(
                        "assets/auth_group/image_location_small.png",
                        height: 70.h,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      input.msg ?? '',
                      textAlign: TextAlign.start,
                      style: CTS(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Gaps.h5,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Row myChatVideoAttachedWidget(
  //video
  TalkMsgModel input,
  ScrollController scrollController,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        textAlign: TextAlign.right,
        formatDateTime(input.updtDttm!),
        style: CTS(fontSize: 12, color: Colors.grey),
      ),
      Gaps.h5,
      Container(
        constraints: const BoxConstraints(
          maxWidth: 310,
        ),
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8)),
            color: const Color(0xfffff700).withOpacity(0.333),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.play_circle,
                color: Palette.mainColor,
              ),
              Gaps.h5,
              Text(
                input.msg ?? '',
                textAlign: TextAlign.start,
                style: CTS(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Gaps.h5,
              Text(
                '2.3MB',
                textAlign: TextAlign.start,
                style: CTS(
                  color: Palette.greyText_60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Row myChatWidget(
  TalkMsgModel input,
  ScrollController scrollController,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        textAlign: TextAlign.right,
        formatDateTime(input.updtDttm!),
        style: CTS(fontSize: 12, color: Colors.grey),
      ),
      Gaps.h5,
      Container(
        constraints: BoxConstraints(
          maxWidth: 0.7.sw,
        ),
        padding: EdgeInsets.only(top: 10.h),
        child: Container(
          margin: EdgeInsets.only(right: 15.w),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r)),
            color: const Color(0xfffff700).withOpacity(0.333),
          ),
          child: Text(
            input.msg ?? '',
            textAlign: TextAlign.start,
            style: CTS(
              color: Colors.black,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    ],
  );
}
