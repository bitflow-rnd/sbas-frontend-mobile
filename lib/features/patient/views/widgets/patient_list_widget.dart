import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/common/widgets/radio_button.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/patient/views/widgets/top_column.dart';
import 'package:sbas/util.dart';
import 'package:sbas/features/lookup/blocs/patient_info_presenter.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/views/patient_lookup_detail_screen.dart';
import 'package:sbas/features/lookup/views/patient_register_screen.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_list_card_item.dart';

Widget patientListWidget(BuildContext context, WidgetRef ref, bool isMyGroup, Function changeGroup) => GestureDetector(
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
                        radioButton(ref, '내조직', '전체', isMyGroup, 11, changeGroup),
                        Gaps.h10,
                        Expanded(
                          flex: 32,
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
            topColumn(patient.count ?? 0),
            Expanded(
              child: ListView.builder(
                itemCount: patient.items.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    ref.invalidate(patientInfoProvider);
                    ref.watch(patientIdProvider.notifier).state = patient.items[index].ptId;

                    if (context.mounted) {
                      await Navigator.push(
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