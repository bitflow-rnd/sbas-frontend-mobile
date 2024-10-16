import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/features/messages/views/widgets/user_list_widget.dart';
import 'package:sbas/features/patient/providers/paitent_provider.dart';

class TalkRoomRegScreen extends ConsumerWidget {
  const TalkRoomRegScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const SBASAppBar(
        title: '대화방 생성',
        elevation: 0.5,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.watch(patientListProvider.notifier).init();
        },
        child: userListWidget(context, ref),
      )
    );
  }

}