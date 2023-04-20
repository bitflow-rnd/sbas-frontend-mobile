import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbas/features/messages/blocs/talk_rooms_block.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

class DirectMessageScreen extends StatefulWidget {
  final bool automaticallyImplyLeading;

  const DirectMessageScreen({Key? key, required this.automaticallyImplyLeading})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DirectMessageScreenState();
  }
}

class _DirectMessageScreenState extends State<DirectMessageScreen> {
  late final TalkRoomsBloc _talkRoomsBloc;

  @override
  void initState() {
    super.initState();
    _talkRoomsBloc = TalkRoomsBloc();
  }

  @override
  void dispose() {
    _talkRoomsBloc.dispose();
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
      body: StreamBuilder<List<TalkRoomsResponseModel>>(
        stream: _talkRoomsBloc.chatRoomListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return talkRoomWidget(snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
