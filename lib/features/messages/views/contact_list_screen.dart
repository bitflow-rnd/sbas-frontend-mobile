import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/user_detail_presenter.dart';
import 'package:sbas/features/messages/models/user_contact_model.dart';
import 'package:sbas/features/messages/presenters/contact_condition_presenter.dart';
import 'package:sbas/features/messages/presenters/contact_list_presenter.dart';
import 'package:sbas/features/messages/views/contact_detail_screen.dart';
import 'package:sbas/features/messages/views/widgets/contact_item_widget.dart';
import 'package:sbas/features/messages/models/contact_list_map.dart';

class ContactListScreen extends ConsumerWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();
    final userDetail = ref.read(userDetailProvider.notifier);
    final userInstTypeCd = userDetail.instTypeCd;
    final userDstr2Cd = userDetail.dutyDstr2Cd;
    final userDstr1Cd = userDstr2Cd.toString().substring(0, 2);
    bool isMyLocation = ref.watch(isMyLocationProvider);
    List<bool> instTypeCdList = ref.watch(instTypeCdListProvider);
    var contactPresenter = ref.watch(contactConditionPresenter);
    contactPresenter.setCondition(myInstTypeCd: userInstTypeCd);

    if (isMyLocation) {
      ref.read(contactConditionPresenter).dstr1Cd = userDstr1Cd;
      ref.read(contactConditionPresenter).dstr2Cd = userDstr2Cd;
    } else {
      ref.read(contactConditionPresenter).dstr1Cd = null;
      ref.read(contactConditionPresenter).dstr2Cd = null;
    }

    var presenter = ref.watch(contactListProvider);
    final dataLoader = ref.read(contactListProvider.notifier);
    var contactList = presenter.value ?? ContactListMap(contactListMap: {});

    void setLocationCondition() {
      if (ref.read(isMyLocationProvider.notifier).state) {
        contactPresenter.dstr1Cd = userDstr1Cd;
        contactPresenter.dstr2Cd = userDstr2Cd;
      } else {
        contactPresenter.dstr1Cd = null;
        contactPresenter.dstr2Cd = null;
      }
    }

    void changeLocation() async {
      ref.read(isMyLocationProvider.notifier).state = !isMyLocation;
      setLocationCondition();
      await dataLoader.loadContacts();
    }

    void changeInstTypeCd() async {
      String code = 'ORGN000';
      String inputData = instTypeCdList
          .asMap()
          .entries
          .where((element) => element.value)
          .map((e) => code + (e.key + 1).toString())
          .join(',');

      print(inputData);

      contactPresenter.instTypeCd = inputData == '' ? null : inputData;
      setLocationCondition();
      await dataLoader.loadContacts();
    }

    return GestureDetector(
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffecedef).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLocationButton(
                            ref, '내지역', isMyLocation, true, changeLocation),
                        _buildLocationButton(
                            ref, '전국', !isMyLocation, false, changeLocation),
                      ],
                    ),
                  ),
                ),
                Gaps.h10,
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          contactPresenter.search = searchController.text;
                          await dataLoader.loadContacts();
                        },
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
                  GestureDetector(
                    onTap: () => {
                      ref.read(instTypeCdListProvider.notifier).state[0] =
                          !instTypeCdList[0],
                      changeInstTypeCd(),
                    },
                    child: locationItem(
                        text: "병상배정반", isSelected: instTypeCdList[0]),
                  ),
                  GestureDetector(
                    onTap: () => {
                      ref.read(instTypeCdListProvider.notifier).state[1] =
                          !instTypeCdList[1],
                      changeInstTypeCd(),
                    },
                    child: locationItem(
                        text: "구급대", isSelected: instTypeCdList[1]),
                  ),
                  GestureDetector(
                    onTap: () => {
                      ref.read(instTypeCdListProvider.notifier).state[2] =
                          !instTypeCdList[2],
                      changeInstTypeCd(),
                    },
                    child: locationItem(
                        text: "보건소", isSelected: instTypeCdList[2]),
                  ),
                  GestureDetector(
                    onTap: () => {
                      ref.read(instTypeCdListProvider.notifier).state[3] =
                          !instTypeCdList[3],
                      changeInstTypeCd(),
                    },
                    child: locationItem(
                        text: "의료진", isSelected: instTypeCdList[3]),
                  ),
                  GestureDetector(
                    onTap: () => {
                      ref.read(instTypeCdListProvider.notifier).state[4] =
                          !instTypeCdList[4],
                      changeInstTypeCd(),
                    },
                    child:
                        locationItem(text: "전산", isSelected: instTypeCdList[4]),
                  ),
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
                  userInstTypeCd == 'ORGN0005'
                      ? rowWrapper(
                          header: "등록요청",
                          alarmCount: (contactList
                                      .contactListMap['contacts']?.contacts ??
                                  [])
                              .where(
                                  (element) => element.userStatCd == "URST0001")
                              .toList()
                              .length,
                          isOpen: ref
                              .watch(contactRegReqIsOpenProvider.notifier)
                              .state,
                          function: () {
                            ref
                                    .watch(contactRegReqIsOpenProvider.notifier)
                                    .state =
                                !ref.watch(contactRegReqIsOpenProvider);
                          },
                          contactList: (contactList
                                      .contactListMap['contacts']?.contacts ??
                                  [])
                              .where(
                                  (element) => element.userStatCd == "URST0001")
                              .toList(),
                          context: context,
                        )
                      : Container(),
                  rowWrapper(
                    header: "즐겨찾기",
                    alarmCount:
                        (contactList.contactListMap['favorites']?.contacts ??
                                [])
                            .length,
                    isOpen: ref.watch(contactMyFavProvider.notifier).state,
                    function: () {
                      ref.watch(contactMyFavProvider.notifier).state =
                          !ref.watch(contactMyFavProvider);
                    },
                    contactList:
                        contactList.contactListMap['favorites']?.contacts ?? [],
                    context: context,
                  ),
                  rowWrapper(
                    header: "내 조직",
                    alarmCount:
                        (contactList.contactListMap['contacts']?.contacts ?? [])
                            .where((element) =>
                                element.instId ==
                                ref.watch(userDetailProvider.notifier).instId)
                            .toList()
                            .length,
                    isOpen:
                        ref.watch(contactMyOrgIsOpenProvider.notifier).state,
                    function: () {
                      ref.watch(contactMyOrgIsOpenProvider.notifier).state =
                          !ref.watch(contactMyOrgIsOpenProvider);
                    },
                    contactList:
                        (contactList.contactListMap['contacts']?.contacts ?? [])
                            .where((element) =>
                                element.instId ==
                                ref.watch(userDetailProvider.notifier).instId)
                            .toList(),
                    context: context,
                  ),

                  // rowWrapper("등록요청", 1, ref.read(contactRegReqIsOpenProvider), context), // Pass ref here
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocationButton(WidgetRef ref, String text, bool isSelected,
      bool isMyLocation, Function changeLocation) {
    return InkWell(
      onTap: () => changeLocation(),
      child: Container(
        height: 40.h,
        width: 45.w,
        decoration: isSelected ? BoxDecoration(
          color: Palette.mainColor,
          borderRadius: BorderRadius.circular(6),
        ) : null,
        child: Center(
          child: Text(
            text,
            style: CTS.bold(
              color: isSelected ? Colors.white : Palette.greyText_60,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  rowWrapper(
      {required String header,
      required int alarmCount,
      bool hasOpen = true,
      required bool isOpen,
      Function()? function,
      required List<UserContact> contactList,
      required BuildContext context}) {
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
                        color: const Color(0xff676a7a),
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
                    const Spacer(),
                    if (hasOpen)
                      InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: function,
                        child: Icon(
                          isOpen
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
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
            shrinkWrap: true,
            // Adjust this based on your layout
            physics: const NeverScrollableScrollPhysics(),
            // Prevent scrolling within the ListView
            itemCount: contactList.length,
            separatorBuilder: (context, index) => Divider(
              height: 1.h,
              thickness: 0.8.h,
              color: Palette.greyText_20,
            ),
            itemBuilder: (context, index) {
              final e = contactList[index];
              return InkWell(
                child: ContactItem(
                  userContact: e,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetailScreen(
                        contact: e,
                        isRequest: e.userStatCd == "URST0001",
                      ),
                    ),
                  );
                },
              );
            },
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  locationItem({required String text, required bool isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 7.w),
      margin: EdgeInsets.only(right: 4.5.w),
      decoration: BoxDecoration(
          color: isSelected ? Palette.mainColor : Palette.white,
          borderRadius: BorderRadius.circular(13.5.r),
          border: Border.all(
              color: isSelected ? Palette.mainColor : Palette.greyText_20,
              width: 1)),
      child: Text(
        text,
        style: CTS(
          color: isSelected ? Colors.white : Palette.greyText,
          fontSize: 12,
        ),
      ),
    );
  }
}

final contactMyOrgIsOpenProvider = StateProvider<bool>((ref) => true);
final contactRegReqIsOpenProvider = StateProvider<bool>((ref) => true);
final contactMyFavProvider = StateProvider<bool>((ref) => true);
final isMyLocationProvider = StateProvider<bool>((ref) => true);
final instTypeCdListProvider =
    StateProvider<List<bool>>((ref) => [false, false, false, false, false]);
