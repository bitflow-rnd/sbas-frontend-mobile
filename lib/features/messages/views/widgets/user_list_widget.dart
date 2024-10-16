import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/common/widgets/search_text_form_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/providers/user_list_provider.dart';
import 'package:sbas/features/messages/views/widgets/user_card_item.dart';
import 'package:sbas/util.dart';

Widget userListWidget(
    BuildContext context, WidgetRef ref) {
  final ScrollController _scrollController = ScrollController();

  _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(userListProvider.notifier).updateUserList();
    }
  });

  return GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Stack(
      children: [
        ref.watch(userListProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Palette.mainColor,
              ),
            ),
          ),
          data: (user) => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gaps.h10,
                          Expanded(
                            flex: 32,
                            child: SearchTextFormWidget(
                                hintText: '이름, 휴대폰번호 또는 생년월일 6자리)'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1.h,
              ),
              Container(
                padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: CTS.bold(color: Palette.black),
                              text: '조회결과 ',
                              children: [
                                TextSpan(
                                  text: ' ${user.count}',
                                  style: CTS.bold(
                                    color: const Color(0xFF00BFFF),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '명',
                                      style: CTS.bold(
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: user.items.length,
                  itemBuilder: (context, index) => UserCardItem(model: user.items[index]),
                ),
              ),
              if (user.count != 0)
                SizedBox(
                  height: 55.h,
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomPositionedSubmitButton(
            text: '대화방 생성',
            function: () {
              _showCreateRoomModal(context, ref);
            }),
        ),
      ],
    ),
  );
}

void _showCreateRoomModal(BuildContext context, WidgetRef ref) {
  final TextEditingController roomNameController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 12),
              child: Text(
                '대화방 생성',
                style: CTS.medium(fontSize: 15.sp),
              ),
            ),
            TextField(
              controller: roomNameController,
              style: CTS.medium(fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: '대화방 이름',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              ),
            ),
            Gaps.v10,
            SizedBox(
              height: 40.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final roomName = roomNameController.text;
                  ref.read(userListProvider.notifier).regChatRoom(roomName);
                  // 화면 이동
                  Navigator.pop(context);
                  Navigator.pop(context);

                  ref.read(selectedUserIdProvider).clear();
                  ref.read(selectedUserNmProvider).clear();

                  showToast("대화방 생성");
                },
                child: const Text('확인'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
