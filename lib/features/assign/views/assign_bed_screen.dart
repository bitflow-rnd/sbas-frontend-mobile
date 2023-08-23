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
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/views/hospital_bed_request_screen_v2.dart';
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
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await ref.watch(assignBedProvider.notifier).reloadPatients();
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 46.h,
                              ),
                              child: list.items.isNotEmpty
                                  ? ListView.separated(
                                      itemCount: list.count,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.r,
                                        horizontal: 16.r,
                                      ),
                                      itemBuilder: (_, index) => AsgnCardItem(
                                        model: list.items[index],
                                        color: getStateColor(
                                          list.items[index].bedStatCd,
                                        ),
                                      ),
                                      separatorBuilder: (_, index) => Gaps.v8,
                                    )
                                  : const Center(child: Text('내역이 없습니다.')),
                            ),
                            Column(
                              children: [
                                const Spacer(),
                                BottomSubmitBtn(
                                  onPressed: () {
                                    ref.read(patientRegProvider.notifier).init();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HospitalBedRequestScreenV2(patient: null),
                                      ),
                                    );
                                  },
                                  text: '병상요청',
                                ),
                              ],
                            ),
                          ],
                        ),
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
