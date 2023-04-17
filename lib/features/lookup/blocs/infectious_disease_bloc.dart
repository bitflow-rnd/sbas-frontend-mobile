import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/lookup/models/infectious_disease_model.dart';

class InfectiousDiseaseBloc extends AsyncNotifier<InfectiousDiseaseModel> {
  @override
  FutureOr<InfectiousDiseaseModel> build() {
    final patientDiseaseModel = InfectiousDiseaseModel.empty();

    return patientDiseaseModel;
  }
}

final infectiousDiseaseProvider =
    AsyncNotifierProvider<InfectiousDiseaseBloc, InfectiousDiseaseModel>(
  () => InfectiousDiseaseBloc(),
);
