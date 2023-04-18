import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/agency_detail_bloc.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/lookup/blocs/infectious_disease_bloc.dart';
import 'package:sbas/features/lookup/models/epidemiological_report_model.dart';
import 'package:sbas/util.dart';

class InfectiousDisease extends ConsumerStatefulWidget {
  InfectiousDisease({
    required this.report,
    required this.formKey,
    super.key,
  });
  @override
  ConsumerState<InfectiousDisease> createState() => _InfectiousDiseaseState();

  final _titles = [
    '담당보건소',
    '코로나19증상 및 징후',
    '확진검사결과',
    '질병급',
    '발병일',
    '환자등 분류',
    '비고',
    '입원여부',
    '요양기관명',
    '요양기관기호',
    '요양기관주소',
    '요양기관 전화번호',
    '진단의사 성명',
    '신고기관장 성명',
    '기타 진료정보 이미지·영상',
  ];
  final _subTitles = [
    '진단일',
    '신고일',
  ];
  final _status = [
    '입원',
    '외래',
    '재택',
    '기타',
  ];
  final GlobalKey<FormState> formKey;
  final EpidemiologicalReportModel report;
}

class _InfectiousDiseaseState extends ConsumerState<InfectiousDisease> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.read(infectiousDiseaseProvider.notifier);
    final patientImage = ref.watch(infectiousImageProvider);
    final ImagePicker picker = ImagePicker();

    return ref.watch(infectiousDiseaseProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          data: (disease) => Form(
            key: widget.formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget._titles.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(i + 1)}.${widget._titles[i]}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        Gaps.v4,
                        if (i == 0)
                          Row(
                            children: [
                              Expanded(
                                child: ref.watch(agencyRegionProvider).when(
                                      loading: () =>
                                          const SBASProgressIndicator(),
                                      error: (error, stackTrace) => Center(
                                        child: Text(
                                          error.toString(),
                                          style: const TextStyle(
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                      ),
                                      data: (region) => FormField(
                                        builder: (field) => _selectRegion(
                                          region.where(
                                            (e) => e.id?.cdGrpId == 'SIDO',
                                          ),
                                          field,
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                        initialValue: widget.report.dstr1Cd,
                                      ),
                                    ),
                              ),
                              Gaps.h8,
                              Expanded(
                                child: ref.watch(agencyDetailProvider).when(
                                      loading: () =>
                                          const SBASProgressIndicator(),
                                      error: (error, stackTrace) => Center(
                                        child: Text(
                                          error.toString(),
                                          style: const TextStyle(
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                      ),
                                      data: (publicHealthCenter) => FormField(
                                        builder: (field) =>
                                            _selectPublicHealthCenter(
                                                publicHealthCenter, field),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        if (i != 7 && i != 14)
                          TextFormField(
                            decoration: getInputDecoration(
                              '${widget._titles[i]}${i == 3 || i == 4 || i == 8 || i == 12 || i == 13 ? '을' : '를'} 입력해주세요.',
                            ),
                            controller: TextEditingController(
                              text: vm.init(i, widget.report),
                            ),
                            onSaved: (newValue) =>
                                vm.setTextEditingController(i, newValue),
                            onChanged: (value) =>
                                vm.setTextEditingController(i, value),
                            validator: (value) {
                              if (i == 7) {}
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(i == 4
                                    ? r'[0-9|.-]'
                                    : r'[A-Z|a-z|0-9|()-|가-힝|ㄱ-ㅎ|ㆍ|ᆢ]'),
                              ),
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: i == 4 || i == 11
                                ? TextInputType.number
                                : TextInputType.text,
                            maxLength: i == 4 ? 10 : null,
                          )
                        else if (i == 7)
                          SizedBox(
                            height: 36,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => Gaps.h8,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget._status.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () =>
                                    setState(() => vm.setTextEditingController(
                                          i,
                                          widget._status[index],
                                        )),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: widget._status[index] ==
                                              disease.admsYn
                                          ? BorderStyle.none
                                          : BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      18,
                                    ),
                                    color:
                                        widget._status[index] == disease.admsYn
                                            ? Colors.lightBlue
                                            : Colors.transparent,
                                  ),
                                  child: Text(
                                    widget._status[index],
                                    style: TextStyle(
                                      color: widget._status[index] ==
                                              disease.admsYn
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else if (i == 14)
                          InkWell(
                            onTap: () async {
                              final image = await picker.pickImage(
                                source: kDebugMode
                                    ? ImageSource.gallery
                                    : ImageSource.camera,
                                preferredCameraDevice: CameraDevice.front,
                                requestFullMetadata: false,
                              );
                              if (image != null) {
                                ref
                                    .read(infectiousImageProvider.notifier)
                                    .state = image;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  if (patientImage != null &&
                                      patientImage.path.isNotEmpty)
                                    Image.file(
                                      File(patientImage.path),
                                    )
                                  else
                                    Image.asset(
                                      'assets/auth_group/camera_location.png',
                                    ),
                                  if (patientImage != null &&
                                      patientImage.path.isNotEmpty)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          ref
                                              .read(infectiousImageProvider
                                                  .notifier)
                                              .state = null;
                                          ref
                                              .read(infectiousAttcProvider
                                                  .notifier)
                                              .state = null;
                                          ref
                                              .read(infectiousIsUploadProvider
                                                  .notifier)
                                              .state = true;
                                        },
                                        icon: Icon(
                                          Icons.cancel_sharp,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        if (i == 4)
                          for (int i = 0; i < widget._subTitles.length; i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gaps.v8,
                                Text(
                                  widget._subTitles[i],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                Gaps.v2,
                                TextFormField(
                                  decoration: getInputDecoration(
                                    '${widget._subTitles[i]}을 입력해주세요.',
                                  ),
                                  controller: TextEditingController(
                                    text: vm.init(i + 100, widget.report),
                                  ),
                                  onSaved: (newValue) =>
                                      vm.setTextEditingController(
                                          i + 100, newValue),
                                  onChanged: (value) => vm
                                      .setTextEditingController(i + 100, value),
                                  validator: (value) => null,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9|.-]'),
                                    ),
                                    FilteringTextInputFormatter
                                        .singleLineFormatter,
                                  ],
                                  autovalidateMode: AutovalidateMode.always,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                ),
                              ],
                            ),
                        Gaps.v12,
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
  }

  Widget _selectRegion(
          Iterable<BaseCodeModel> region, FormFieldState<Object?> field) =>
      SizedBox(
        child: Column(
          children: [
            InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: region
                      .map(
                        (e) => DropdownMenuItem(
                          alignment: Alignment.center,
                          value: e.cdNm,
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              e.cdNm ?? '',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  hint: const SizedBox(
                    width: 150,
                    child: Text(
                      '시/도 선택',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  isDense: true,
                  isExpanded: true,
                  onChanged: (value) {
                    ref
                        .read(agencyDetailProvider.notifier)
                        .updatePublicHealthCenter(
                          region.firstWhere((e) => e.cdNm == value).id?.cdId ??
                              '',
                        );
                    field.didChange(value);
                  },
                  value: field.value != '' ? field.value : null,
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
  Widget _selectPublicHealthCenter(
          Iterable<InfoInstModel> center, FormFieldState<Object?> field) =>
      SizedBox(
        child: Column(
          children: [
            InputDecorator(
              decoration: _inputDecoration,
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
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  hint: const SizedBox(
                    width: 150,
                    child: Text(
                      '보건소 선택',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  isDense: true,
                  isExpanded: true,
                  onChanged: (value) {},
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
  InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      );
  InputDecoration get _inputDecoration => InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        contentPadding: const EdgeInsets.all(0),
      );
}
