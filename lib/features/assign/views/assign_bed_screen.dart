import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/assign/views/widgets/card_item_widget.dart';
import 'package:sbas/features/assign/views/widgets/top_navbar_widget.dart';
import 'package:sbas/features/assign/views/widgets/top_search_widget.dart';
import 'package:sbas/features/lookup/views/patient_register_screen.dart';
import 'package:sbas/util.dart';

class AssignBedScreen extends ConsumerWidget {
  const AssignBedScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        backgroundColor: Palette.white,
        appBar: Bitflow.getAppBar(
          '병상 배정 현황',
          automaticallyImplyLeading,
          0.5,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ref.watch(assignBedProvider).when(
                loading: () => const SBASProgressIndicator(),
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(
                      color: Palette.mainColor,
                    ),
                  ),
                ),
                data: (list) => Column(
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
                      child: TopNavbar(
                        x: list.x,
                        list: ref.watch(assignCountProvider),
                      ),
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
                              const WidgetSpan(
                                child: Gaps.h1,
                              ),
                              TextSpan(
                                text: '${list.count}',
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
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 46.h,
                            ),
                            child: ListView.separated(
                              itemCount: list.count,
                              padding: EdgeInsets.symmetric(
                                vertical: 8.r,
                                horizontal: 16.r,
                              ),
                              itemBuilder: (_, index) => CardItem(
                                model: list.items[index],
                                color: getStateColor(
                                  list.items[index].bedStatCd,
                                ),
                              ),
                              separatorBuilder: (_, index) => Gaps.v8,
                            ),
                          ),
                          Column(
                            children: [
                              const Spacer(),
                              BottomSubmitBtn(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientRegScreen(),
                                  ),
                                ),
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
        ),
      );

  final bool automaticallyImplyLeading;

  static const String routeName = 'assign';
  static const String routeUrl = '/assign';
}
