import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/messages/views/chatting_screen.dart';
import 'package:sbas/features/messages/views/contact_detail_screen.dart';
import 'package:sbas/features/messages/views/contact_list_screen.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

final selecteTabProvider = StateProvider(
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

    void onTap(BuildContext context, tkrmId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChattingScreen(
            userId: ref.watch(talkRoomsProvider.notifier).userId,
            tkrmId: tkrmId,
            provider: ref.watch(talkRoomsProvider.notifier),
          ),
        ),
      );
    }

    void onContactTap(BuildContext context, contract) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactDetailScreen(
            contact: contract,
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Palette.white,
        // appBar: AppBar(
        //   systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarBrightness: Brightness.light,
        //     statusBarColor: Colors.transparent,
        //     statusBarIconBrightness: Brightness.dark,
        //   ),
        //   backgroundColor: Colors.white,
        //   elevation: 1,
        //   leading: Image.asset(
        //     'assets/home/home_logo.png',
        //     alignment: Alignment.topLeft,
        //   ),
        //   leadingWidth: 256,
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.notifications_none,
        //         color: Color(0xFF696969),
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.menu,
        //         color: Color(0xFF696969),
        //       ),
        //     ),
        //   ],
        // ),
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
                                    '메세지',
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
              selectedTabIndex != 0
                  ? Expanded(
                      child: TalkRoomWidget(onTap: (tkrmId) => onTap(context, tkrmId)),
                    )
                  : const Expanded(child: ContactListScreen()),
            ],
          ),
        ));
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}

class Contract {
  Contract(this.name, this.phone, this.organization);
  String name;
  String phone;
  String organization;
}
