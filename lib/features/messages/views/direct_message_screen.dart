import 'package:flutter/material.dart';
import 'package:sbas/features/messages/blocs/talk_rooms_block.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';

class DirectMessageScreen extends StatefulWidget {
  final automaticallyImplyLeading;
  final userId;
  const DirectMessageScreen(
      {super.key,
      required this.automaticallyImplyLeading,
      required this.userId});

  @override
  _DirectMessageScreenState createState() => _DirectMessageScreenState();
}

class _DirectMessageScreenState extends State<DirectMessageScreen> {
  late final TalkRoomsBloc _talkRoomsBloc;

  @override
  void initState() {
    super.initState();
    _talkRoomsBloc = TalkRoomsBloc(userId: 'haksung59');
  }

  @override
  void dispose() {
    _talkRoomsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talk Rooms Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Talk Rooms'),
        ),
        body: StreamBuilder<List<TalkRoomsResponseModel>>(
          stream: _talkRoomsBloc.chatRoomListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final chatRoomList = snapshot.data!;
              return ListView.builder(
                itemCount: chatRoomList.length,
                itemBuilder: (context, index) {
                  final chatRoom = chatRoomList[index];
                  return ListTile(
                    title: Text(chatRoom.tkrmNm!),
                    subtitle: Text(chatRoom.msg!),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
