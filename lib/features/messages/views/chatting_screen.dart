import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';
import 'package:sbas/features/messages/blocs/talk_room_bloc.dart';
import 'package:sbas/features/messages/models/talk_msg_model.dart';
import 'package:sbas/features/messages/views/widgets/chat_widget.dart';

class ChattingScreen extends StatefulWidget {
  final String userId;
  final String tkrmId;

  const ChattingScreen({
    Key? key,
    required this.userId,
    required this.tkrmId,
  }) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late final TalkRoomBloc _talkRoomBloc;
  late final TextEditingController _messageController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _talkRoomBloc = TalkRoomBloc(
      userId: widget.userId,
      tkrmId: widget.tkrmId,
    );
    _messageController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _talkRoomBloc.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          widget.tkrmId,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => print('hi'),
            icon: const Icon(
              Icons.search,
              color: Color(0xFF696969),
            ),
          ),
          IconButton(
            onPressed: () => print('bye'),
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF696969),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<TalkMsgModel>>(
              stream: _talkRoomBloc.chatDetailListStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(microseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
                return chatWidget(userToken.name!, snapshot, _scrollController);
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _textSender(),
          ),
        ],
      ),
    );
  }

  Widget _textSender() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: '메세지를 입력해 주세요.',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _messageController.text.trim().isEmpty
                  ? null
                  : () {
                      _talkRoomBloc.sendMessage(_messageController.text);
                      _messageController.clear();
                    },
            ),
          ],
        ),
      ),
    );
  }
}
