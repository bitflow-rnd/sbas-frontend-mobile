import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/assign/views/widgets/card_item_widget.dart';
import 'package:sbas/features/assign/views/widgets/top_search_widget.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/views/hospital_bed_request_screen_v2.dart';
import 'package:sbas/util.dart';

class AssignBedScreen extends ConsumerWidget {
  const AssignBedScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });
  final List<String> headerList = const ["병상요청", "병상배정", "이송", "입퇴원", "완료"];
  final bool isRight = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        backgroundColor: Palette.white,
        appBar: SBASAppBar(
          title: '병상 배정 현황',
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () async {
                await ref.watch(assignBedProvider.notifier).reloadPatients();
              },
            ),
          ],
          elevation: 0.5,
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 16.r),
                    //   child: TopNavbar(
                    //     x: list.x,
                    //     list: ref.watch(assignCountProvider),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        5,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            ref.read(assignBedProvider.notifier).setTopNavItem(index);
                                          },
                                          child: SizedBox(
                                            width: 0.22.sw,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  headerList[index],
                                                  style: CTS.medium(
                                                    color: Colors.black,
                                                    fontSize: 13.sp,
                                                  ),
                                                ).c,
                                                if (ref.watch(assignCountProvider)[index] != 0) Gaps.h3,
                                                if (ref.watch(assignCountProvider)[index] != 0)
                                                  Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ref.read(assignTabXindexProvider.notifier).state == index ? Palette.mainColor : Colors.transparent,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: ref.read(assignTabXindexProvider.notifier).state == index
                                                              ? Palette.mainColor
                                                              : Palette.greyText_60,
                                                          width: 1.r,
                                                          style: BorderStyle.solid,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(2.3.r),
                                                        child: Center(
                                                          child: Text(
                                                            '${ref.watch(assignCountProvider)[index]}',
                                                            style: CTS.medium(
                                                              color:
                                                                  ref.read(assignTabXindexProvider.notifier).state == index ? Colors.white : Palette.greyText,
                                                              fontSize: 9.sp,
                                                            ),
                                                          ).c,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 16.w),
                                      height: 6.h,
                                      width: 0.22.sw * 5,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffecedef),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      padding: EdgeInsets.only(left: 0.22.sw * ref.watch(assignTabXindexProvider.notifier).state + 16.w),
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: Container(
                                        width: 0.22.sw,
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          color: Palette.mainColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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
                                        builder: (context) => HospitalBedRequestScreenV2(
                                          patient: null,
                                          isPatientRegister: true,
                                        ),
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
