import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/widgets/card_item_widget.dart';
import 'package:sbas/features/assign/views/widgets/top_navbar_widget.dart';
import 'package:sbas/features/assign/views/widgets/top_search_widget.dart';
import 'package:sbas/features/assign_request/assign_request_screen.dart';

class AssignBedScreen extends ConsumerWidget {
  const AssignBedScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '병상 배정 현황',
        automaticallyImplyLeading,
        0.5,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 16.w,
              ),
              child: const TopSearch(),
            ),
            Divider(
              color: Palette.greyText_20,
              height: 1,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: const TopNavbar(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.r,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: '총',
                    style: CTS.bold(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      WidgetSpan(
                        child: Gaps.h1,
                      ),
                      TextSpan(
                        text: '17',
                        style: CTS.bold(
                          color: Palette.mainColor,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '명',
                        style: CTS.bold(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(children: [
                      CardItem(patientAge: '88', patientName: '김*준', patientSex: '남', symbol: '병상요청', color: Colors.green),
                      CardItem(patientAge: '88', patientName: '김*준', patientSex: '남', symbol: '배정대기', color: Palette.primary),
                      CardItem(patientAge: '88', patientName: '김*준', patientSex: '남', symbol: '이송대기', hospital: "분당 서울대 병원", color: Palette.primary),
                      CardItem(patientAge: '88', patientName: '김*준', patientSex: '남', symbol: '  이송중  ', hospital: "분당 서울대 병원", color: Palette.primary),
                      CardItem(patientAge: '88', patientName: '김*준', patientSex: '남', symbol: '    입원    ', color: Palette.red),
                    ]),
                  ),
                  Column(
                    children: [
                      Spacer(),
                      BottomSubmitBtn(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AssignBedRequestScreen()));
                        },
                        text: '병상요청',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final bool automaticallyImplyLeading;

  static const String routeName = 'assign';
  static const String routeUrl = '/assign';
}
