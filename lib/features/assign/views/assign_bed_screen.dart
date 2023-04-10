
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/assign/views/widgets/card_item_widget.dart';
import 'package:sbas/features/assign/views/widgets/top_navbar_widget.dart';
import 'package:sbas/features/assign/views/widgets/top_search_widget.dart';

class AssignBedScreen extends ConsumerWidget {
  const AssignBedScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '병상 배정 현황',
        automaticallyImplyLeading,
        0.5,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: TopSearch(),
            ),
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                14,
                16,
                0,
              ),
              child: TopNavbar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: const TextSpan(
                    text: '총',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: [
                      WidgetSpan(
                        child: Gaps.h1,
                      ),
                      TextSpan(
                        text: '17',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: '명',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const CardItem(
              patientAge: '88',
              patientName: '김*준',
              patientSex: '남',
              symbol: '병상요청',
              color: Colors.green,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
              ),
            ),
            const BottomSubmitBtn(
              onPressed: null,
              text: '병상요청',
            ),
          ],
        ),
      ),
    );
  }

  final bool automaticallyImplyLeading;
}
