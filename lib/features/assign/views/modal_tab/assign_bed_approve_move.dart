import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/common/widgets/custom_cupertino_radio.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/bloc/safety_center_bloc.dart';
import 'package:sbas/features/assign/bloc/safety_region_bloc.dart';
import 'package:sbas/features/assign/presenters/assign_bed_move_aprv_presenter.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/lookup/presenters/patient_timeline_presenter.dart';
import 'package:sbas/features/lookup/views/widgets/patient_top_info_widget.dart';
import 'package:sbas/features/patient/models/patient_model.dart';
import 'package:sbas/util.dart';

class AssignBedApproveMoveScreen extends ConsumerStatefulWidget {
  const AssignBedApproveMoveScreen({
    super.key,
    required this.patient,
    required this.bdasSeq,
    required this.formKey,
  });
  final Patient patient;
  final int? bdasSeq;
  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<AssignBedApproveMoveScreen> createState() => _AssignBedApproveMoveScreenState();
}

class _AssignBedApproveMoveScreenState extends ConsumerState<AssignBedApproveMoveScreen> {
  List<String> list = ['관할 구급대', '대표 연락처', '탑승대원 및 의료진', '배차정보', '메시지'];
  List<String> hintList = ['', '연락처 입력', '', '차량번호 입력', '메시지 입력'];
  // 이부분 의료기관명 readonly 로 들어갈부분.

  static final Map<String, String> crewMap = {
    'crew1': '대원#1',
    'crew2': '대원#2',
    'crew3': '대원#3',
  };
  String _selectedCrew = crewMap.keys.first;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(asgnBdMvAprPresenter.notifier).init(
            bdasSeq: widget.bdasSeq,
            ptId: widget.patient.ptId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: SBASAppBar(
        title: '이송 처리',
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Palette.greyText,
              weight: 24.h,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        elevation: 0.5,
      ),
      body: Form(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ref.watch(asgnBdMvAprPresenter).when(
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                      style: const TextStyle(
                        color: Palette.mainColor,
                      ),
                    ),
                  ),
                  loading: () => const SBASProgressIndicator(),
                  data: (_) => Column(
                    children: [
                      PatientTopInfo(patient: widget.patient),
                      Divider(
                        color: Palette.greyText_20,
                        height: 1,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              children: [
                                Gaps.v20,
                                _getTitle(list[0], true),
                                Gaps.v8,
                                Row(
                                  children: [
                                    Expanded(
                                      child: ref.watch(saftyRegionPresenter).when(
                                            loading: () => const SBASProgressIndicator(),
                                            error: (error, stackTrace) => Center(
                                              child: Text(
                                                error.toString(),
                                                style: const TextStyle(
                                                  color: Palette.mainColor,
                                                ),
                                              ),
                                            ),
                                            data: (region) => FormField(
                                              builder: (field) => _selectRegion(
                                                region.where(
                                                  (e) => e.cdGrpId == 'SIDO' && e.cdId == '27',
                                                ),
                                                field,
                                              ),
                                              validator: (value) {
                                                return value == null ? '시/도를 선택해주세요' : null;
                                              },
                                              // initialValue: widget.dstr1Cd,
                                            ),
                                          ),
                                    ),
                                    Gaps.h8,
                                    Expanded(
                                      child: ref.watch(saftyCenterPresenter).when(
                                            loading: () => const SBASProgressIndicator(),
                                            error: (error, stackTrace) => Center(
                                              child: Text(
                                                error.toString(),
                                                style: const TextStyle(
                                                  color: Palette.mainColor,
                                                ),
                                              ),
                                            ),
                                            data: (publicHealthCenter) => FormField(
                                              builder: (field) => _selectSaftyCenter(publicHealthCenter, field),
                                              validator: (value) {
                                                return value == null ? '구급대를 선택해주세요.' : null;
                                              },
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                                _getTextInputField(i: 0, hint: "직접 입력"),
                                Gaps.v20,
                                _getTitle(list[2], false),
                                Gaps.v8,
                                _thirdRow(1000),
                                Gaps.v8,
                                _thirdRow(2000),
                                Gaps.v8,
                                _thirdRow(3000),
                                Gaps.v20,
                                _getTitle(list[1], true),
                                Gaps.v8,
                                FormField(
                                  builder: (field) => Container(
                                    alignment: Alignment.centerLeft,
                                    child: CustomCupertinoRadio(
                                      choices: crewMap,
                                      onChange: onGenderSelected,
                                      initialKeyValue: _selectedCrew,
                                      selectedColor: Palette.mainColor,
                                      notSelectedColor: Palette.greyText_60,
                                      formField: field,
                                    ),
                                  ),
                                  validator: (value) {
                                    var crew1Telno = ref.watch(asgnBdMvAprPresenter.notifier).getText(index: 1002);
                                    var crew2Telno = ref.watch(asgnBdMvAprPresenter.notifier).getText(index: 2002);
                                    var crew3Telno = ref.watch(asgnBdMvAprPresenter.notifier).getText(index: 3002);
                                    if (value == null) {
                                      return '대원의 연락처를 입력해주세요.';
                                    } else if (value == 'crew1' && (crew1Telno == null || crew1Telno == '')) {
                                      return '대원#1의 연락처를 입력해주세요.';
                                    } else if (value == 'crew2' && (crew2Telno == null || crew2Telno == '')) {
                                      return '대원#2의 연락처를 입력해주세요.';
                                    } else if (value == 'crew3' && (crew3Telno == null || crew3Telno == '')) {
                                      return '대원#3의 연락처를 입력해주세요.';
                                    }
                                    return null;
                                  },
                                ),
                                // _getTextInputField(hint: hintList[1], i: 1, type: TextInputType.number, maxLength: 11),
                                Gaps.v20,
                                Row(
                                  children: [
                                    _getTitle(list[3], false),
                                    // Spacer(),
                                    // carNumTag("54더1980"),
                                    // carNumTag("143호1927"),
                                  ],
                                ),
                                Gaps.v8,
                                _getTextInputField(hint: hintList[3], i: 3),
                                Gaps.v20,
                                _getTitle(list[4], false),
                                Gaps.v8,
                                _getTextInputField(hint: hintList[4], i: 4, maxLines: 6),
                                Gaps.v20,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Common.bottomer(
                        rBtnText: "처리 완료",
                        isOneBtn: true,
                        lBtnFunc: () {},
                        rBtnFunc: () async {
                          if (validation()) {
                            var vm = ref.watch(asgnBdMvAprPresenter.notifier);
                            vm.setChfTelno(_selectedCrew);
                            var res = await vm.submit();
                            if (res) {
                              await ref.watch(patientTimeLineProvider.notifier).refresh(widget.patient.ptId, widget.bdasSeq);
                              await ref.watch(assignBedProvider.notifier).reloadPatients(); // 리스트 갱신
                              // ignore: use_build_context_synchronously
                              Common.showModal(
                                context,
                                // ignore: use_build_context_synchronously
                                Common.commonModal(
                                  context: context,
                                  imageWidget: Image.asset(
                                    "assets/auth_group/modal_check.png",
                                    width: 44.h,
                                  ),
                                  imageHeight: 44.h,
                                  mainText: "이송 처리가 완료되었습니다.",
                                  button2Function: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                              // ignore: use_build_context_synchronously
                            }
                            showToast("배차 실패 ");
                          }
                        },
                      )
                    ],
                  ),
                ),
          )),
    );
  }

  void onGenderSelected(String crewKey) {
    final vm = ref.watch(asgnBdMvAprPresenter.notifier);
    setState(() {
      _selectedCrew = crewKey;
    });
    vm.setChfTelno(crewKey);
  }

  bool validation() {
    bool isValid = widget.formKey.currentState?.validate() ?? false;

    if (isValid) {
      widget.formKey.currentState?.save();
    }
    return isValid;
  }

  Widget _selectRegion(Iterable<BaseCodeModel> region, FormFieldState<Object?> field) => SizedBox(
        child: Column(
          children: [
            Container(
              height: 48.h,
              child: InputDecorator(
                decoration: getInputDecoration(""),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    alignment: Alignment.center,
                    items: region
                        .map(
                          (e) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: e.cdId,
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                e.cdNm ?? '',
                                style: TextStyle(fontSize: 13, color: Palette.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    hint: SizedBox(
                      width: 150,
                      child: Text(
                        '시/도 선택',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    isDense: true,
                    isExpanded: true,
                    onChanged: (value) {
                      ref.read(saftyCenterPresenter.notifier).updatePublicHealthCenter(
                            region.firstWhere((e) => e.cdId == value).cdId ?? '',
                          );
                      // ref.read(saftyRegionPresenter.notifier).updateSaftyCenter(
                      //       region.firstWhere((e) => e.cdId == value).cdId ?? '',
                      //     );
                      field.didChange(value);
                    },
                    value: field.value != '' ? field.value : null,
                  ),
                ),
              ),
            ),
            Gaps.v8,
            if (field.hasError)
              FieldErrorText(
                field: field,
              )
          ],
        ),
      );

  Widget _selectSaftyCenter(Iterable<InfoInstModel> center, FormFieldState<Object?> field) => SizedBox(
        child: Column(
          children: [
            Container(
              height: 48.h,
              child: InputDecorator(
                decoration: getInputDecoration(""),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: center
                        .map(
                          (e) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: e.instNm,
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                e.instNm ?? '',
                                style: TextStyle(fontSize: 13, color: Palette.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    hint: SizedBox(
                      width: 150,
                      child: Text(
                        '구급대 선택',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    isDense: true,
                    isExpanded: true,
                    onChanged: (value) {
                      print(value);

                      // ref.read(saftyCenterPresenter.notifier).updateRegion(
                      //       center.firstWhere((e) => e.instNm == value).instNm ?? '',
                      //     );
                      ref.read(asgnBdMvAprPresenter.notifier).changeSaftyCenter(center.firstWhere((element) => element.instNm == value));
                      field.didChange(value);
                    },
                    value: field.value != '' ? field.value : null,
                  ),
                ),
              ),
            ),
            Gaps.v8,
            if (field.hasError)
              FieldErrorText(
                field: field,
              )
          ],
        ),
      );

  Widget carNumTag(String num) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        border: Border.all(
          color: Palette.greyText_20,
          width: 1,
        ),
      ),
      child: Text(
        num,
        style: CTS(fontSize: 13, color: Palette.greyText_80),
      ),
    );
  }

  Column _thirdRow(int i) {
    List<String> dropdownList = ['대원선택'];
    String selectedDropdown = '대원선택';
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: dropdownButton(dropdownList, selectedDropdown)),
            Gaps.h12,
            Expanded(child: _getTextInputField(i: i, hint: '직급')),
            Gaps.h12,
            Expanded(child: _getTextInputField(i: i + 1, hint: '이름'))
          ],
        ),
        Gaps.v8,
        _getTextInputField(i: i + 2, hint: '연락처', type: TextInputType.number, maxLength: 11),
      ],
    );
  }

  Widget _getTextInputField({
    required int i,
    required String hint,
    TextInputType type = TextInputType.text,
    int? maxLines,
    FormFieldState<Object?>? field,
    int? maxLength,
  }) {
    final vm = ref.watch(asgnBdMvAprPresenter.notifier);
    return TextFormField(
      style: CTS(fontSize: 12.sp, color: Palette.black),
      decoration: Common.getInputDecoration(hint),
      controller: TextEditingController(
          text: vm.getText(index: i)
      )..selection = TextSelection.fromPosition(
          TextPosition(offset: vm.getText(index: i)!.length),
      ),
      onSaved: (newValue) {
        vm.setTextEditingController(index: i, value: newValue);
        // field?.didChange(newValue);
      },
      onChanged: (value) {
        vm.setTextEditingController(index: i, value: value);
      },
      validator: (value) {
        return null;
      },
      readOnly: hint == '',
      inputFormatters: vm.getRegExp(index: i) != null
          ? [
              FilteringTextInputFormatter.allow(
                RegExp(vm.getRegExp(index: i)!),
              )
            ]
          : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: type,
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }

  Widget _getTitle(String title, bool isRequired) => Row(
        children: [
          Text(
            title,
            style: CTS.medium(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          Text(
            isRequired ? '(필수)' : '(선택)',
            style: CTS.medium(
              fontSize: 13,
              color: !isRequired ? Colors.grey.shade600 : Palette.mainColor,
            ),
          ),
        ],
      );

  Widget dropdownButton(List<String> dlist, String sel) {
    return SizedBox(
      height: 45.h,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(4.r),
        decoration: Common.getInputDecoration(""),
        value: sel,
        items: dlist.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: CTS(fontSize: 10, color: Palette.black),
            ),
          );
        }).toList(),
        onChanged: (dynamic value) {
          // setState(() {
          //   selectedDropdown = value;
          // });
        },
      ),
    );
  }

  void addCrewMap() {

  }
}
