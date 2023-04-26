import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/talk_rooms_response_model.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/messages/views/chatting_screen.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

class DirectMessageScreen extends ConsumerStatefulWidget {
  final bool automaticallyImplyLeading;

  const DirectMessageScreen({
    Key? key,
    required this.automaticallyImplyLeading,
  }) : super(key: key);

  @override
  ConsumerState<DirectMessageScreen> createState() {
    return _DirectMessageScreenState();
  }
}

class _DirectMessageScreenState extends ConsumerState<DirectMessageScreen> {
  void onTap(userId, tkrmId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChattingScreen(
          userId: userId,
          tkrmId: tkrmId,
        ),
      ),
    );
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
      body: ref.watch(talkRoomsStateProvider).when(
        data: (List<TalkRoomsResponseModel> rooms) {
          return talkRoomWidget(rooms, onTap);
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
      ),
      // StreamBuilder<List<TalkRoomsResponseModel>>(
      //   stream: ref.watch(talkRoomsStateProvider),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return talkRoomWidget(snapshot, onTap);
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text(snapshot.error.toString()));
      //     } else {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
