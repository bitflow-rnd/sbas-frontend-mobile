import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbas/features/messages/blocs/talk_room_block.dart';
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

  @override
  void initState() {
    super.initState();
    _talkRoomBloc = TalkRoomBloc(
      userId: widget.userId,
      tkrmId: widget.tkrmId,
    );
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _talkRoomBloc.dispose();
    _messageController.dispose();
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
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Color(0xFF696969),
            ),
          ),
          IconButton(
            onPressed: () {},
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
                return ChatWidget(snapshot);
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
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
                  hintText: 'Type a message',
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
                    },
            ),
          ],
        ),
      ),
    );
  }
}
