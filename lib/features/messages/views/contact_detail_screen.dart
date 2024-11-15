import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/common_button_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/providers/user_detail_presenter.dart';
import 'package:sbas/features/messages/models/chat_request_model.dart';
import 'package:sbas/features/messages/models/favorite_request_model.dart';
import 'package:sbas/features/messages/models/user_contact_model.dart';
import 'package:sbas/features/messages/providers/contact_list_provider.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/messages/repos/contact_repo.dart';
import 'package:sbas/features/messages/views/chatting_screen.dart';
import 'package:sbas/features/messages/views/recent_activity_list_screen.dart';
import 'package:sbas/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sbas/features/messages/models/activity_history_list_model.dart';

class ContactDetailScreen extends ConsumerStatefulWidget {
  final UserContact contact;
  final bool isRequest;

  const ContactDetailScreen({
    Key? key,
    required this.contact,
    this.isRequest = true,
  }) : super(key: key);

  @override
  ConsumerState<ContactDetailScreen> createState() =>
      _ContactDetailScreenState();
}

class _ContactDetailScreenState extends ConsumerState<ContactDetailScreen> {
  var isLoading = false;

  void toggleFavorite(String userId) {
    setState(() {
      isLoading = false;
    });
  }

  Future<ActivityHistoryListModel> getActivity() async {
    return await ref
        .read(contactRepoProvider)
        .getRecentActivity(widget.contact.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(userDetailProvider.notifier).userId;
    final mbrId = widget.contact.id ?? '';
    var presenter = ref.watch(contactListProvider.notifier);

    final ptTypeCdList = widget.contact.ptTypeCd?.split(';');

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true; // 로딩 시작
                  });
                  final request =
                      FavoriteRequestModel(id: userId, mbrId: mbrId);

                  try {
                    if (widget.contact.isFavorite) {
                      await ref
                          .read(contactRepoProvider)
                          .deleteFavorite(request);
                      widget.contact.isFavorite = false;
                    } else {
                      await ref.read(contactRepoProvider).addFavorite(request);
                      widget.contact.isFavorite = true;
                    }
                    presenter.loadContacts();
                  } catch (e) {
                    showToast(e.toString());
                    return;
                  } finally {
                    toggleFavorite(userId);
                  }
                },
                icon: widget.contact.isFavorite
                    ? const Icon(
                        Icons.star_outlined,
                        color: Color(0xFFD0A72F),
                      )
                    : const Icon(
                        Icons.star_border_sharp,
                        color: Color(0xFF696969),
                      ),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Positioned(
                top: 0.h,
                child: Image.asset(
                  "assets/message/hospital_image.png",
                  height: 240.h,
                  width: 1.sw,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 220.h),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.r),
                              topRight: Radius.circular(24.r)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 16.h),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/message/doctor_icon.png",
                                  height: 44.h,
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.contact.userNm ?? "",
                                      style: CTS.bold(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Gaps.v6,
                                    Text(
                                      "${widget.contact.instNm ?? ""} / ${widget.contact.ocpCd ?? ""}",
                                      style: CTS(
                                        color: Palette.greyText_80,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Divider(
                                thickness: 1,
                                height: 1,
                                color: Palette.greyText_20),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 24),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '휴대폰번호',
                                      style: CTS.medium(
                                        color: Palette.greyText_80,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      widget.contact.telno ?? "",
                                      style: CTS(
                                        color: Palette.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            launchSms(
                                                number: widget.contact.telno);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5.r),
                                              // margin: EdgeInsets.only(right: 8.w),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Palette.greyText_20,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Icon(Icons.message_rounded,
                                                  color: Palette.black,
                                                  size: 16.r)),
                                        ),
                                        Gaps.h10,
                                        GestureDetector(
                                          onTap: () {
                                            launch(
                                                "tel://${widget.contact.telno}");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5.r),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Palette.greyText_20,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Icon(Icons.phone,
                                                color: Palette.greyText_80,
                                                size: 16.r),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Gaps.v20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '직장전화번호',
                                      style: CTS.medium(
                                        color: Palette.greyText_80,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      widget.contact.telno ?? "",
                                      style: CTS(
                                        color: Palette.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Gaps.h48,
                                        GestureDetector(
                                          onTap: () {
                                            launch(
                                                "tel://${widget.contact.telno}");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5.r),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Palette.greyText_20,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Icon(Icons.phone,
                                                color: Palette.greyText_80,
                                                size: 16.r),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Gaps.v20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '담당환자 유형',
                                      style: CTS.medium(
                                        color: Palette.greyText_80,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Row(
                                      children: ptTypeCdList
                                              ?.map((ptTypeCd) => Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            10.w), // 오른쪽에 간격 추가
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w,
                                                              vertical: 5.h),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Palette
                                                                .greyText_20,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    13.5.r),
                                                      ),
                                                      child: Text(
                                                        getPtTypeCdNm(ptTypeCd),
                                                        style: CTS(
                                                            color: Palette
                                                                .greyText,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ))
                                              .toList() ??
                                          [],
                                    )
                                  ],
                                ),
                                Gaps.v20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '최근활동',
                                      style: CTS.medium(
                                        color: Palette.greyText_80,
                                        fontSize: 13,
                                      ),
                                    ),
                                    FutureBuilder(
                                        future: getActivity(),
                                        builder: (context, snapshot) {
                                          var data = snapshot.data?.items ?? ActivityHistoryListModel(items: []).items;
                                          if (snapshot.hasData) {
                                            if (data.isNotEmpty) {
                                              return GestureDetector(
                                                onTap: () => {
                                                  Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecentActivityListScreen(userId: userId,activities: data),
                                                    ),
                                                  )
                                                },
                                                child: Text(
                                                    formatDateTimeForActivity(data.first.rgstDttm ?? ''),
                                                    style: CTS.medium(
                                                        color: Palette.greyText_80,
                                                        fontSize: 13)),
                                              );
                                            } else {
                                              return Text(
                                                '없음',
                                                style: CTS.medium(
                                                    color: Palette.greyText_80,
                                                    fontSize: 13),
                                              );
                                            }
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CommonButton(
                              function: () async {
                                final request = ChatRequestModel(
                                  id: userId,
                                  userId: mbrId,
                                );
                                await ref.read(contactRepoProvider).doChat(request)
                                    .then((value) => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChattingScreen(
                                                userId: userId,
                                                tkrmId: value['tkrmId'],
                                                tkrmNm: value['tkrmNm'],
                                              ),
                                            ),
                                          )
                                        });
                                ref.read(talkRoomsProvider.notifier).updateUserId(userId);
                              },
                              text: "대화 하기")
                        ],
                      ),
                    ),
                  ),
                  if (widget.isRequest)
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Palette.white,
                                border: Border.all(
                                  color: Palette.greyText_20,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "반려",
                                style: CTS(
                                  color: Palette.greyText_80,
                                  fontSize: 16,
                                ),
                              ).c,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Palette.mainColor,
                                border: Border.all(
                                  color: Palette.mainColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "승인",
                                style: CTS(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ).c,
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ],
          ),
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  @override
  void dispose() {
    ref.read(talkRoomsProvider.notifier).disconnect();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    final _focusNode = FocusNode();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focusNode.requestFocus());
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.r),
          ),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '사용자 등록 승인',
                            style: CTS.medium(
                              fontSize: 15,
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
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  hintText: '메시지 입력',
                                  enabledBorder: _outlineInputBorder,
                                  focusedBorder: _outlineInputBorder,
                                  errorBorder: _outlineInputBorder,
                                )),
                          ),
                          Gaps.h8,
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Text(
                                  '승인',
                                  style:
                                      CTS(color: Palette.white, fontSize: 13),
                                ),
                              ),
                              onPressed: () {
                                String text = _textEditingController.text;
                                // Perform action with the entered text here
                                Navigator.pop(context, text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
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
}
