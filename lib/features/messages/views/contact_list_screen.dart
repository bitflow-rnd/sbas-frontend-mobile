import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/models/user_contact_model.dart';
import 'package:sbas/features/messages/presenters/contact_list_presenter.dart';
import 'package:sbas/features/messages/views/contact_detail_screen.dart';

class ContactListScreen extends ConsumerWidget {
  const ContactListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(contactListProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Palette.mainColor,
              ),
            ),
          ),
          data: (contactList) => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        locationItem(text: "보건소", isSelected: true),
                        locationItem(text: "병상배정반"),
                        locationItem(text: "의료진"),
                        locationItem(text: "구급대"),
                        locationItem(text: "전산"),
                        Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: Palette.greyText_60,
                          size: 22.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        rowWrapper(
                          "등록요청",
                          1,
                          true,
                          ref.watch(contactRegReqIsOpenProvider.notifier).state,
                          () {
                            ref.watch(contactRegReqIsOpenProvider.notifier).state = !ref.watch(contactRegReqIsOpenProvider);
                          },
                          contactList.contacts ?? [],
                          context,
                        ),
                        rowWrapper(
                          "내 조직",
                          0,
                          true,
                          ref.watch(contactMyOrgIsOpenProvider.notifier).state,
                          () {
                            ref.watch(contactMyOrgIsOpenProvider.notifier).state = !ref.watch(contactMyOrgIsOpenProvider);
                          },
                          contactList.contacts ?? [],
                          context,
                        ),
                        rowWrapper(
                          "즐겨찾기",
                          10,
                          true,
                          ref.watch(contactMyFavProvider.notifier).state,
                          () {
                            ref.watch(contactMyFavProvider.notifier).state = !ref.watch(contactMyFavProvider);
                          },
                          contactList.contacts ?? [],
                          context,
                        ),

                        // rowWrapper("등록요청", 1, ref.read(contactRegReqIsOpenProvider), context), // Pass ref here
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
  }

  rowWrapper(String header, int alarmCount, bool hasOpen, bool isOpen, Function()? function, List<UserContact> contactList, BuildContext context) {
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
                    if (alarmCount != 0)
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
                      InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: function,
                        child: Icon(
                          isOpen ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
                          color: Palette.greyText_60,
                          size: 22.h,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (isOpen)
          ListView.separated(
            shrinkWrap: true, // Adjust this based on your layout
            physics: const NeverScrollableScrollPhysics(), // Prevent scrolling within the ListView
            itemCount: contactList.length,
            separatorBuilder: (context, index) => Divider(
              height: 1.h,
              thickness: 0.8.h,
              color: Palette.greyText_20,
            ),
            itemBuilder: (context, index) {
              final e = contactList[index];
              return InkWell(
                child: contactItem(e),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetailScreen(contact: e),
                    ),
                  );
                },
              );
            },
          ),
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

  contactItem(UserContact userContact) {
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
                userContact.userNm ?? "",
                style: CTS.medium(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
              Gaps.v8,
              Text(
                "${userContact.instNm ?? ""} / ${userContact.ocpCd ?? ""}",
                style: CTS(
                  color: Palette.greyText_80,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final contactMyOrgIsOpenProvider = StateProvider<bool>((ref) => true);
final contactRegReqIsOpenProvider = StateProvider<bool>((ref) => false);
final contactMyFavProvider = StateProvider<bool>((ref) => false);
