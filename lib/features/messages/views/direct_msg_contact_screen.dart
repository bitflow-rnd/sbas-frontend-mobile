import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/views/contact_list_screen.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';
import 'package:sbas/util.dart';

final selecteTabProvider = StateProvider.autoDispose(
  //tab 전환용
  (ref) => 0,
);

class DMContactScreen extends ConsumerStatefulWidget {
  // Change to ConsumerStatefulWidget
  final bool automaticallyImplyLeading;

  const DMContactScreen({
    Key? key,
    required this.automaticallyImplyLeading,
  }) : super(key: key);

  @override
  ConsumerState<DMContactScreen> createState() => _DMContactScreenState();
}

class _DMContactScreenState extends ConsumerState<DMContactScreen> {
  @override
  Widget build(BuildContext context) {
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
                    onTap: () => _showBottomSheet(context),
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
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController pnumController = TextEditingController();
    // StateProvider<String> inviteUserTypeProvicer = StateProvider<String>((ref) => '');
    String selectedType = '';

    final _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
    List list = ["내 조직", "외부 조직"];

    showModalBottomSheet(
      isDismissible: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setStateBottomSheet) {
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '사용자 초대',
                            style: CTS.medium(
                              fontSize: 15.sp,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              weight: 24.h,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextField(
                              focusNode: _focusNode,
                              controller: nameController,
                              style: CTS.medium(
                                fontSize: 13.sp,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                hintText: '이름을 입력해 주세요',
                                enabledBorder: _outlineInputBorder,
                                focusedBorder: _outlineInputBorder,
                                errorBorder: _outlineInputBorder,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: pnumController,
                              style: CTS.medium(
                                fontSize: 13.sp,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                hintText: '휴대폰 번호를 입력해 주세요.',
                                enabledBorder: _outlineInputBorder,
                                focusedBorder: _outlineInputBorder,
                                errorBorder: _outlineInputBorder,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v12,
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffe4e4e4),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                for (int i = 0; i < list.length; i++)
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 10.h),
                                          child: Text(list[i], style: CTS.bold(fontSize: 11, color: Colors.transparent)),
                                        ),
                                        Gaps.h1,
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < list.length; i++)
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setStateBottomSheet(() {
                                        selectedType = list[i];
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: selectedType == list[i] ? const Color(0xff538ef5) : Colors.transparent,
                                              borderRadius: selectedType == list[i] ? BorderRadius.circular(6) : null,
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 10.h),
                                            child: Text(
                                              list[i],
                                              style: CTS.bold(
                                                fontSize: 11,
                                                color: selectedType == list[i] ? Palette.white : Palette.greyText_60,
                                              ),
                                            ),
                                          ),
                                        ),
                                        list[i] != list.last
                                            ? Container(
                                                height: 12,
                                                width: 1,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff676a7a).withOpacity(0.2),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Gaps.v24,
                      //bottom button -> submit to server
                      Container(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, 'ok');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Palette.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            '초대하기',
                            style: CTS.bold(
                              fontSize: 13.sp,
                              color: Palette.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ).then((value) => {
          //dismiss keyboard
          FocusScope.of(context).requestFocus(FocusNode()),
          if (value == 'ok' && nameController.text.isNotEmpty && pnumController.text.isNotEmpty && selectedType.isNotEmpty)
            {
              //v1provider to post api call
              // V1Provider().

              V1Provider()
                  .postAsync(
                      'private/user/invite',
                      toJson({
                        "name": nameController.text,
                        "phone": pnumController.text,
                        "type": selectedType == "내 조직" ? "0001" : "0002",
                      }))
                  .then((value) {
                Navigator.pop(context, "success");
                showToast("초대 성공");
              })
            }
          else
            {showToast("invalid data")}
        });
  }

  InputBorder get _outlineInputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      );

  // static String routeName = 'directMessage';
  // static String routeUrl = '/directMessage';
}
