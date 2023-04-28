import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/features/messages/views/chatting_screen.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

class DirectMessageScreen extends ConsumerWidget {
  final bool automaticallyImplyLeading;

  const DirectMessageScreen({
    Key? key,
    required this.automaticallyImplyLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTap(BuildContext context, tkrmId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChattingScreen(
            userId: ref.watch(talkRoomsProvider.notifier).userId,
            tkrmId: tkrmId,
            // provider: ref.watch(talkRoomsProvider.notifier),
          ),
        ),
      );
    }

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
      body: Builder(builder: (context) {
        return TalkRoomWidget(onTap: (tkrmId) => onTap(context, tkrmId));
      }),
    );
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
