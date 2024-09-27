import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbas/common/repos/file_repo.dart';
import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';
import 'package:sbas/features/lookup/repos/patient_repo.dart';

class PatientDiseaseInfoPresenter extends AsyncNotifier {
  @override
  FutureOr build() {
    _patientRepository = ref.read(patientRepoProvider);
  }

  Future<PatientDiseaseInfoModel> getAsync(String? ptId) async {
    if (ptId != null && ptId.isNotEmpty) {
      var patientDiseaseInfoModel = await _patientRepository.getDiseaseInfo(ptId);
      // var fileList = ref.read(diagImageProvider.notifier).state;
      // patientDiseaseInfoModel.diagAttcId?.split(";").forEach((attcId) {
      //   print(fileRepository.getDiagImage(attcId).toString());
      // });
      return patientDiseaseInfoModel;
    }
    return PatientDiseaseInfoModel(undrDsesNms: [], ptTypeNms: [], svrtTypeNms: []);
  }

  Future<Uint8List> getImageBytes() async {
    return await fileRepository.getDiagImage("AT0000002227");
  }

  late final PatientRepository _patientRepository;
  final fileRepository = FileRepository();
}

final patientDiseaseInfoProvider = AsyncNotifierProvider<PatientDiseaseInfoPresenter, void>(
      () => PatientDiseaseInfoPresenter(),
);
final diagImageProvider = StateProvider<List<XFile>>((ref) => []);