import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';

import 'base_code_provider.dart';

class SigunguNotifier extends AutoDisposeFamilyAsyncNotifier<List<BaseCodeModel>, String> {

  @override
  FutureOr<List<BaseCodeModel>> build(String arg) {
    return _baseCodeProvider.getGugun(arg);
  }

  final _baseCodeProvider = BaseCodeProvider();
}

final sigunguProvider = AsyncNotifierProvider.autoDispose.family<SigunguNotifier, List<BaseCodeModel>, String>(
  SigunguNotifier.new,
);