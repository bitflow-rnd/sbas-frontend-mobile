import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/activity_history_model.dart';
import 'package:sbas/features/messages/views/widgets/activity_card_widget.dart';

class RecentActivityListScreen extends ConsumerWidget {
  final String userId;
  final List<ActivityHistoryModel> activities;

  const RecentActivityListScreen({
    super.key,
    required this.userId,
    required this.activities,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: const Text(
          '활동 내역',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          return ActivityCardWidget(
            // Assuming your ActivityCardWidget takes an Activity object as a parameter
            activity: activities[index],
          );
        },
      ),
    );
  }
}
