import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/messages/views/chatting_screen.dart';
import 'package:sbas/features/messages/views/contract_detail_screen.dart';
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
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Image.asset(
            'assets/home/home_logo.png',
            alignment: Alignment.topLeft,
          ),
          leadingWidth: 256,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFF696969),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF696969),
              ),
            ),
          ],
        ),
        body: Column(
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
                : contactFragment(context),
          ],
        ));
  }

  Widget contactFragment(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 16.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              child: Container(
                                height: 40.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffecedef).withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '   전국',
                                  style: CTS.bold(
                                    color: Palette.greyText_60,
                                    fontSize: 11,
                                  ),
                                ).c,
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: 48.w,
                              decoration: BoxDecoration(
                                color: Palette.mainColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '내지역',
                                style: CTS.bold(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ).c,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.h10,
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,

                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search_rounded,
                        ),
                      ),
                      fillColor: Colors.white,
                      // filled: true,
                      hintText: '이름, 휴대폰번호 또는 소속기관명',
                      hintStyle: CTS.bold(
                        color: Colors.grey,
                        fontSize: 11,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                    ),
                  ),
                ),
                Gaps.h4,
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Palette.greyText_60,
                  size: 22.h,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            child: Row(
              children: [
                locationItem(text: "보건소", isSelected: true),
                locationItem(text: "병상배정반"),
                locationItem(text: "의료진"),
                locationItem(text: "구급대"),
                locationItem(text: "보건전산"),
                Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: Palette.greyText_60,
                  size: 22.h,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  rowWrapper(
                      "등록요청",
                      1,
                      false,
                      true,
                      [
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                      ],
                      context),
                  rowWrapper(
                      "즐겨찾기",
                      1,
                      true,
                      true,
                      [
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                      ],
                      context),
                  rowWrapper(
                      "내 조직",
                      1,
                      true,
                      true,
                      [
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                        Contract("우상욱 팀장", "010-1234-5678", "병상배정반 / 대구광역시 / 레몬헬스케어"),
                      ],
                      context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  rowWrapper(String header, int alarmCount, bool hasOpen, bool isOpen, List<Contract> contactList, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: Palette.greyText_08,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Text(
                      header,
                      style: CTS.medium(
                        color: Color(0xff676a7a),
                        fontSize: 13,
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
                        alarmCount.toString(),
                        style: CTS.bold(color: Colors.white, fontSize: 10),
                      ).c,
                    ),
                    Spacer(),
                    if (hasOpen)
                      Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: Palette.greyText_60,
                        size: 22.h,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (isOpen)
          Column(
            children: [
              ...contactList.map((e) {
                return InkWell(
                  child: contactItem(e),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                                contact: e,
                              )),
                    );
                  },
                );
              }).toList(),
            ],
          )
      ],
    );
  }

  locationItem({required String text, bool? isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 7.w),
      margin: EdgeInsets.only(right: 4.5.w),
      decoration: BoxDecoration(
          color: isSelected == null ? Palette.white : Palette.mainColor,
          borderRadius: BorderRadius.circular(13.5.r),
          border: Border.all(color: isSelected == null ? Palette.greyText_20 : Palette.mainColor, width: 1)),
      child: Text(
        text,
        style: CTS(
          color: isSelected == null ? Palette.greyText : Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  contactItem(Contract c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Image.asset(
            "assets/message/doctor_icon.png",
            height: 36.h,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.name,
                style: CTS.medium(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Gaps.v8,
              Text(
                c.organization,
                style: CTS(
                  color: Palette.greyText_80,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
