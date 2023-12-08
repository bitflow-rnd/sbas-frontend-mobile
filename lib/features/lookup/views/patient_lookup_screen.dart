import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_info_presenter.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/views/patient_lookup_detail_screen.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/views/patient_register_screen.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_list_card_item.dart';
import 'package:sbas/util.dart';

class PatientLookupScreen extends ConsumerStatefulWidget {
  const PatientLookupScreen({
    required this.automaticallyImplyLeading,
    super.key,
  });

  final bool automaticallyImplyLeading;

  static String routeName = 'lookup';
  static String routeUrl = '/lookup';

  @override
  ConsumerState<PatientLookupScreen> createState() => PatientLookupScreenState();
}

class PatientLookupScreenState extends ConsumerState<PatientLookupScreen> {
  final String selectedDropdown = '최근등록순';
  final List<String> dropdownList = [
    '최근등록순',
    '최근3개월',
    '최근1년',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Palette.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "환자 목록",
            style: CTS.medium(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          elevation: 0.5,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: const BackButton(
            color: Colors.black,
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.watch(patientLookupProvider.notifier).refresh();
          },
          child: _getGestureDetector(context, ref),
        ),
      );

  Widget _getGestureDetector(BuildContext context, WidgetRef ref) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Stack(
      children: [
        ref.watch(patientLookupProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Palette.mainColor,
              ),
            ),
          ),
          data: (patient) => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _getTopRadioButton(),
                          Gaps.h10,
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search_rounded,
                                  ),
                                ),
                                fillColor: Colors.white,
                                hintText: '이름, 휴대폰번호 또는 생년월일 6자리',
                                hintStyle: CTS.bold(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1.h,
              ),
              _getTopColumn(patient.count ?? 0),
              Expanded(
                child: ListView.builder(
                  itemCount: patient.items.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      ref.watch(patientIdProvider.notifier).state = patient.items[index].ptId;
                      ref.invalidate(patientInfoProvider);
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PatientLookupDetailScreen(),
                          ),
                        );
                      }
                    },
                    child: PaitentCardItem(
                      model: patient.items[index],
                      color: getStateColor(""
                        // patient.items[index].bedStatCd,
                      ),
                    ),
                  ),
                ),
              ),
              if (patient.count != 0)
                SizedBox(
                  height: 55.h,
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomPositionedSubmitButton(
              text: '환자 등록',
              function: () {
                ref.read(patientRegProvider.notifier).init();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientRegScreen(patient: null),
                  ),
                );
              }),
        ),
      ],
    ),
  );

  Widget _getTopColumn(int length) => Container(
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: CTS.bold(color: Palette.black),
                      text: '조회결과 ',
                      children: [
                        TextSpan(
                          text: ' $length',
                          style: CTS.bold(
                            color: const Color(0xFF00BFFF),
                          ),
                          children: [
                            TextSpan(
                              text: '명',
                              style: CTS.bold(
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                    width: 100.w,
                    child: DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(4.r),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      value: selectedDropdown,
                      items: dropdownList
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: CTS(fontSize: 11, color: Palette.black),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  Widget _getTopRadioButton() => Expanded(
        flex: 2,
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 40.h,
                      width: 52.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffecedef).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '   전체',
                        style: CTS.bold(
                          color: Palette.greyText_60,
                          fontSize: 11,
                        ),
                      ).c,
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 52.w,
                    decoration: BoxDecoration(
                      color: Palette.mainColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '내조직',
                      style: CTS.bold(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ).c,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

}
