import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/repos/file_repo.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_attc_model.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/util.dart';

Row othersChatWidget(
  TalkMsgModel input,
  ScrollController scrollController,
) {
  var chat = input;
  String? userImage = 'assets/message/doctor_icon.png';

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Gaps.h16,
      CircleAvatar(backgroundImage: AssetImage(userImage), radius: 20.r),
      Gaps.h10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.rgstUserId!,
            style: CTS(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 0.63.sw,
                ),
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  margin: EdgeInsets.only(right: 5.w),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.r),
                        topRight: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r)),
                    color: Colors.white,
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
              Text(
                textAlign: TextAlign.left,
                formatDateTime(input.updtDttm!),
                style: CTS(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Row othersPhotoChatWidget(
  TalkMsgModel input,
  ScrollController scrollController,
  BuildContext context,
) {
  var chat = input;
  final fileRepository = FileRepository();
  String? userImage = 'assets/message/doctor_icon.png';

  Future<List<BaseAttcModel>> getFileList() {
    return fileRepository.getFileList(input.attcId!);
  }

  Future<void> downloadFile(
      String attcGrpId, String attcId, String fileNm) async {
    await fileRepository
        .downloadPublicImageFile(attcGrpId, attcId, fileNm)
        .then((value) => {
      Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "파일 다운로드 완료",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          imageHeight: 44.h,
        ),
      )
    });
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Gaps.h16,
      CircleAvatar(backgroundImage: AssetImage(userImage), radius: 20.r),
      Gaps.h10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.rgstUserId!,
            style: CTS(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 0.63.sw,
                ),
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  margin: EdgeInsets.only(right: 5.w),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.r),
                        topRight: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r)),
                    color: Colors.white,
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
                                          "${dotenv.env['URL']}${file.uriPath}/${file.fileNm}",
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
                            return GestureDetector(
                              onTap: () => {
                                Common.showModal(
                                  context,
                                  Common.commonModal(
                                    context: context,
                                    mainText: "해당 파일이 없습니다.",
                                    imageWidget: Image.asset(
                                      "assets/auth_group/modal_cross.png",
                                      width: 44.h,
                                    ),
                                    imageHeight: 44.h,
                                  ),
                                )
                              },
                              child: Image.asset(
                                "assets/auth_group/image_location_small.png",
                                height: 70.h,
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      Text(
                        input.msg ?? '',
                        textAlign: TextAlign.start,
                        style: CTS(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.left,
                formatDateTime(input.updtDttm!),
                style: CTS(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
