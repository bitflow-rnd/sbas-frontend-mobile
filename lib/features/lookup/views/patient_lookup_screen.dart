import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_sub_position_btn_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/lookup/views/patient_lookup_detail_screen.dart';
import 'package:sbas/features/lookup/views/patient_register_screen.dart';

class PatientLookupScreen extends ConsumerWidget {
  const PatientLookupScreen({
    required this.automaticallyImplyLeading,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Bitflow.getAppBar(
          '환자 목록',
          false,
          0,
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
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    data: (patient) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.search_rounded,
                                            ),
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: '이름, 휴대폰번호 또는 주민등록번호 앞 6자리',
                                          hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.filter_alt_outlined,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 36,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => Gaps.h6,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 2,
                                  itemBuilder: (context, index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        24,
                                      ),
                                      color: Colors.lightBlue,
                                    ),
                                    child: const Text(
                                      '내조직담당',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.v8,
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      text: '검색결과 총',
                                      children: [
                                        TextSpan(
                                          text: ' ${patient.length}',
                                          style: const TextStyle(
                                            color: Color(0xFF00BFFF),
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: '명',
                                              style: TextStyle(
                                                color: Color(0xFF000000),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        24,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text(
                                          '   최근등록순',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down_sharp,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height -
                                    256 -
                                    64,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 4,
                                ),
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PatientLookupDetailScreen(
                                          patient: patient.list![index],
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 0.1,
                                            spreadRadius: 0.1,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/patient.png',
                                            width: 48,
                                          ),
                                          Gaps.h8,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text:
                                                          '${patient.list?[index].ptNm?.replaceRange(
                                                        1,
                                                        2,
                                                        '*',
                                                      )} (${patient.list?[index].gndr}/${getAge(patient.list?[index])}세)',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text: '  ',
                                                        ),
                                                        WidgetSpan(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 12,
                                                              vertical: 4,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: getStateColor(
                                                                  true,
                                                                  patient
                                                                      .list?[
                                                                          index]
                                                                      .bedStatCd),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Text(
                                                              '${patient.list?[index].bedStatNm}',
                                                              style: TextStyle(
                                                                color: getStateColor(
                                                                    false,
                                                                    patient
                                                                        .list?[
                                                                            index]
                                                                        .bedStatCd),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gaps.v4,
                                              const Text(
                                                '분당서울대병원',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Gaps.v2,
                                              Text(
                                                getAddress(
                                                    patient.list?[index]),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Gaps.v2,
                                              Text(
                                                getDateTimeFormat(patient
                                                    .list?[index].updtDttm),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                height: 32,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 6,
                                                ),
                                                child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 4,
                                                      horizontal: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: const Text(
                                                      '#중증',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Gaps.h6,
                                                  itemCount: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => Gaps.v8,
                                  itemCount: patient.length ?? 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              Positioned(
                bottom: 18,
                left: 18,
                right: 18,
                child: BottomPositionedSubmitButton(
                  text: '신규 환자 등록',
                  function: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientRegScreen(
                        isNewPatient: true,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  final bool automaticallyImplyLeading;
}
