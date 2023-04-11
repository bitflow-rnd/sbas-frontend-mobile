import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';

class HospitalBedRequestScreen extends ConsumerWidget {
  const HospitalBedRequestScreen({
    this.patient,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '병상 요청',
        true,
        0,
      ),
      body: const Placeholder(),
    );
  }

  final Patient? patient;
}
