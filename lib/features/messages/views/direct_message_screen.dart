import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/features/messages/repos/talk_rooms_repo.dart';
import 'package:sbas/features/messages/views/widgets/talk_room_widget.dart';

class DirectMessageScreen extends ConsumerWidget {
  const DirectMessageScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talkRooms = ref.watch(talkRoomsProvider);

    getChatRooms() async {
      return await talkRooms.getMyChats();
    }

    return Scaffold(
      appBar: Bitflow.getAppBar(
        '연락처/DM',
        automaticallyImplyLeading,
        0.5,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: FutureBuilder(
                future: getChatRooms(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: TalkRoomWidget(snapshot),
                        )
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  final bool automaticallyImplyLeading;
  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
