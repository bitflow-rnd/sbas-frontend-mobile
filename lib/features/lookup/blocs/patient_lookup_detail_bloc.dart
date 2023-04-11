import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDetailBloc extends AsyncNotifier {
  @override
  FutureOr build() {}
}

final patientDetailProvider = AsyncNotifierProvider<PatientDetailBloc, void>(
  () => PatientDetailBloc(),
);
final patientProgressProvider = StateProvider.autoDispose<int>((ref) => 0);
