import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/views/patient_lookup_detail_screen.dart';
import 'package:sbas/features/lookup/views/patient_register_screen.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_list_card_item.dart';
import 'package:sbas/features/lookup/views/widgets/paitent_reg_info_modal.dart';

class PatientLookupScreen extends ConsumerWidget {
  PatientLookupScreen({
    required this.automaticallyImplyLeading,
    super.key,
  });
  final bool automaticallyImplyLeading;
  final String selectedDropdown = '최근등록순';
  final List<String> dropdownList = [
    '최근등록순',
    '최근3개월',
    '최근1년',
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
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
          actions: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              margin: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {
                  PatientRegInfoModal().showModal6(context);
                },
                child: Image.asset(
                  "assets/common_icon/flask_icon.png",
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            )
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: automaticallyImplyLeading
              ? const BackButton(
                  color: Colors.black,
                )
              : null,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: GestureDetector(
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
                                    Expanded(
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
                                                      color: const Color(
                                                              0xffecedef)
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: Text(
                                                      '   전체',
                                                      style: CTS.bold(
                                                        color:
                                                            Palette.greyText_60,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
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
                                    ),
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
                                          // filled: true,
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
                                            borderRadius:
                                                BorderRadius.circular(7.r),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(7.r),
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
                        Container(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: CTS.bold(color: Palette.black),
                                        text: '조회결과 ',
                                        children: [
                                          TextSpan(
                                            text: ' ${patient.length}',
                                            style: CTS.bold(
                                              color: const Color(0xFF00BFFF),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '명',
                                                style: CTS.bold(
                                                  color:
                                                      const Color(0xFF000000),
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
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 4.h,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.greyText_30,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.greyText_30,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.greyText_30,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                        ),
                                        value: selectedDropdown,
                                        items: dropdownList.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: CTS(
                                                  fontSize: 11,
                                                  color: Palette.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (dynamic value) {
                                          // setState(() {
                                          //   selectedDropdown = value;
                                          // });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Container(
                              //   height: MediaQuery.of(context).size.height - 256 - 64,
                              //   child: ListView.separated(
                              //     itemBuilder: (context, index) => InkWell(
                              //       onTap: () => Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => PatientLookupDetailScreen(
                              //             patient: patient.list![index],
                              //           ),
                              //         ),
                              //       ),
                              //       child: PaitentCardItem(
                              //           patientAge: '88', patientName: '김*준', hospital: "분당서울대병원", patientSex: '남', symbol: '    입원    ', color: Colors.red),
                              //     ),
                              //     separatorBuilder: (context, index) => Gaps.v8,
                              //     itemCount: patient.length ?? 0,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientLookupDetailScreen(
                                        patient: patient.list![1],
                                      ),
                                    ),
                                  ),
                                  child: PaitentCardItem(
                                      patientAge: '88',
                                      patientName: '김*준',
                                      hospital: "분당서울대병원",
                                      patientSex: '남',
                                      symbol: '    입원    ',
                                      tagList: const ["중증", "중증"],
                                      color: Colors.red),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientLookupDetailScreen(
                                        patient: patient.list![0],
                                      ),
                                    ),
                                  ),
                                  child: PaitentCardItem(
                                      patientAge: '88',
                                      patientName: '김*준',
                                      hospital: "분당서울대병원",
                                      patientSex: '남',
                                      symbol: '    입원    ',
                                      color: Colors.red),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientLookupDetailScreen(
                                        patient: patient.list![3],
                                      ),
                                    ),
                                  ),
                                  child: PaitentCardItem(
                                      patientAge: '88',
                                      patientName: '김*준',
                                      hospital: "분당서울대병원",
                                      patientSex: '남',
                                      symbol: '병상요청',
                                      tagList: const ["중증", "중증"],
                                      color: Colors.green),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientLookupDetailScreen(
                                        patient: patient.list![3],
                                      ),
                                    ),
                                  ),
                                  child: PaitentCardItem(
                                    patientAge: '88',
                                    patientName: '김*준',
                                    hospital: "분당서울대병원",
                                    patientSex: '남',
                                    color: Colors.green,
                                  ),
                                ),
                                if (patient.length != 0)
                                  SizedBox(
                                    height: 55.h,
                                  )
                              ],
                            ),
                          ),
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
                  function: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientRegScreen(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
