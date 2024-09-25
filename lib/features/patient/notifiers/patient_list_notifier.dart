import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/patient/providers/paitent_provider.dart';
import 'package:sbas/features/patient/services/patient_info_service.dart';
import 'package:sbas/features/patient/models/patient_list_model.dart';

class PatientListNotifier extends AsyncNotifier<PatientListModel> {
  var page = 1;

  @override
  FutureOr<PatientListModel> build() async {
    _patientService = ref.read(patientService);

    return await init();
  }

  Future<PatientListModel> init() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _patientService.getPatientList(1);
    });
    if (state.hasError) {}
    page = 1;
    return state.value ?? PatientListModel(items: [], count: 0);
  }

  Future<PatientListModel> updatePatientList() async {
    if (state.isLoading) return state.value ?? PatientListModel(items: [], count: 0);

    page++;
    if (page <= 1) {
      return await init();
    }

    // 기존 상태를 유지하면서 로딩 상태로 변경
    state = AsyncValue.data(state.value!);

    // API 호출 및 데이터 병합
    state = await AsyncValue.guard(() async {
      final newPatientList = await _patientService.getPatientList(page);
      if (state.value != null && newPatientList.items.isNotEmpty) {
        // 기존 리스트에 새로 가져온 데이터 추가
        state.value!.items.addAll(newPatientList.items);
        state.value!.count = newPatientList.count; // count 업데이트
        return state.value!;
      }

      if(newPatientList.items.isEmpty) {
        //다음 데이터가 없을 경우 기존데이터 반환
        return state.value!;
      }
      return newPatientList; // 기존 데이터가 없을 때는 새로운 리스트로 교체
    });

    if (state.hasError) {
      // 에러 처리 로직 추가 가능
    }

    // state.value가 없으면 빈 리스트를 가진 기본 PatientListModel 반환
    return state.value ?? PatientListModel(items: [], count: 0);
  }

  late final PatientService _patientService;

}