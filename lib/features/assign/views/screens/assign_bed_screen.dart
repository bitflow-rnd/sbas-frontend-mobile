import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/assign/views/widgets/top_search_widget.dart';

class AssignBedScreen extends ConsumerStatefulWidget {
  const AssignBedScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });

  @override
  ConsumerState<AssignBedScreen> createState() => _AssignBedScreenState();

  final bool automaticallyImplyLeading;
}

class _AssignBedScreenState extends ConsumerState<AssignBedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '병상 배정 현황',
        widget.automaticallyImplyLeading,
        0.5,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: TopSearch(),
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            /*
            Row(
              children: [
                Container(
                  child: Row(
                    children: const [
                      Text(
                        '병상요청',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Gaps.h1,
                      CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        maxRadius: 10,
                        child: Text(
                          '7',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
            */
          ],
        ),
      ),
    );
  }
}
