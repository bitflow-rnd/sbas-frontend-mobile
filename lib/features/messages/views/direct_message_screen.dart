
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/features/messages/repos/talk_rooms_repo.dart';

class DirectMessageScreen extends ConsumerWidget {
  const DirectMessageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talkRooms = ref.watch(talkRoomsProvider);

    return Scaffold(
      appBar: Bitflow.getAppBar(
        '연락처/DM',
        false,
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
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final chatRooms =
                          await talkRooms.getMyChats(); // getMyChats() 호출

                      ListView.builder(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          final chatRoom = chatRooms[index];
                          return ListTile(
                            title: Text(chatRoom.tkrmNm ?? ''),
                            subtitle: Text(chatRoom.msg ?? ''),
                            trailing: Text(chatRoom.rgstDttm ?? ''),
                          );
                        },
                      );
                    },
                    child: const Text('채팅방 불러오기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
