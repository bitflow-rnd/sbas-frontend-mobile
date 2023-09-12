import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/views/contact_list_screen.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

final selecteTabProvider = StateProvider.autoDispose(
  //tab 전환용
  (ref) => 0,
);

class DirectMessageScreen extends ConsumerWidget {
  final bool automaticallyImplyLeading;

  const DirectMessageScreen({
    Key? key,
    required this.automaticallyImplyLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabIndex = ref.watch(selecteTabProvider);

    return Scaffold(
        backgroundColor: Palette.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 82.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    ref.read(selecteTabProvider.notifier).state = 0;
                                  },
                                  child: Text(
                                    '연락처',
                                    style: CTS.medium(
                                      color: Color(0xff676a7a),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4.w),
                                  height: 16.h,
                                  width: 16.h,
                                  decoration: BoxDecoration(
                                      color: Palette.mainColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Bitflow.defaultRadius),
                                      )),
                                  child: Text(
                                    "1",
                                    style: CTS.bold(color: Colors.white, fontSize: 10),
                                  ).c,
                                ),
                              ],
                            ),
                            Gaps.h44,
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    ref.read(selecteTabProvider.notifier).state = 1;
                                  },
                                  child: Text(
                                    '메시지',
                                    style: CTS.medium(
                                      color: Palette.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4.w),
                                  height: 16.h,
                                  width: 16.h,
                                  decoration: BoxDecoration(
                                      color: Palette.mainColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Bitflow.defaultRadius),
                                      )),
                                  child: Text(
                                    "1",
                                    style: CTS.bold(color: Colors.white, fontSize: 10),
                                  ).c,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 12.h),
                                  height: 6.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFecedef),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                Positioned(
                                  left: ref.watch(selecteTabProvider.notifier).state == 0 ? 0 : null,
                                  right: ref.watch(selecteTabProvider.notifier).state == 0 ? null : 0,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    height: 6.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      color: Palette.mainColor,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Gaps.h32,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Palette.mainColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          '+ 사용자 초대',
                          style: CTS.medium(
                            color: Palette.mainColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Palette.greyText_20,
                height: 1,
              ),
              Expanded(
                child: selectedTabIndex == 0 ? const ContactListScreen() : const TalkRoomWidget(),
              ),
            ],
          ),
        ));
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
