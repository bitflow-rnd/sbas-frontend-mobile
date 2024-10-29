import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';

import 'base_code_provider.dart';

class SidoNotifier extends AsyncNotifier<List<BaseCodeModel>> {

  @override
  FutureOr<List<BaseCodeModel>> build() {
    return _baseCodeProvider.getSido();
  }

  final _baseCodeProvider = BaseCodeProvider();
}

final sidoProvider = AsyncNotifierProvider<SidoNotifier, List<BaseCodeModel>>(
  () => SidoNotifier(),
);