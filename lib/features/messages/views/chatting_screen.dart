import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/messages/blocs/talk_room_bloc.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';

import 'package:sbas/features/messages/views/widgets/chat_widget.dart';

class ChattingScreen extends StatefulWidget {
  final String userId;
  final String tkrmId;
  final String tkrmNm;

  const ChattingScreen({
    Key? key,
    required this.userId,
    required this.tkrmId,
    required this.tkrmNm,
  }) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late final TalkRoomBloc _talkRoomBloc;
  late final TextEditingController _messageController;
  late final ScrollController _scrollController;
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  late bool _isButtonEnabled;

  @override
  void initState() {
    super.initState();
    _talkRoomBloc = TalkRoomBloc(
      userId: widget.userId,
      tkrmId: widget.tkrmId,
    );
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    _isButtonEnabled = false;
  }

  @override
  void dispose() {
    _talkRoomBloc.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 화면을 터치하면 포커스 해제
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.tkrmNm,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<TalkMsgModel>>(
                stream: _talkRoomBloc.chatDetailListStream,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return chatWidget(userToken.name!, snapshot, _scrollController, context);
                },
              ),
            ),
            Gaps.v4,
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _textSender(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textSender() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              // Choose the file (image) from gallery
              final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                setState(() {
                  file = pickedFile;
                  _messageController.text = '[이미지]';
                  _isButtonEnabled = true;
                });
              }
            },
            child: Container(
              color: Palette.greyText_20,
              margin: EdgeInsets.only(left: 2.r, right: 2.r),
              child: Image.asset("assets/auth_group/image_location_small.png",
                  width: 42.h),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (value) {
                setState(() {});
                _isButtonEnabled = value.trim().isNotEmpty;
              },
              decoration: InputDecoration(
                  hintText: '메시지 입력',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w)
              ),
              enabled: file == null,
          )),
          InkWell(
            onTap: _isButtonEnabled
                ? () {
                    if (file != null) {
                      _messageController.text = '';
                      _talkRoomBloc.uploadFile(file, _messageController.text);
                    } else {
                      _talkRoomBloc.sendMessage(_messageController.text);
                    }
                    _messageController.clear();
                    setState(() {
                      file = null;
                      _isButtonEnabled = false;
                    });
                  }
                : null,
            child: Container(
                color:
                    _isButtonEnabled ? Palette.mainColor : Palette.greyText_30,
                padding: EdgeInsets.all(12.r),
                margin: EdgeInsets.only(left: 2.r, right: 2.r),
                child: Icon(
                  Icons.send,
                  color: Palette.white,
                  size: 20.h,
                )),
          )
        ],
      ),
    );
  }
}
