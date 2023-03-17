import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/repository/find_id_repo.dart';

class FindIdViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    _repository = ref.read(findIdRepo);
  }

  String getFindId() {
    const id = 'lemon';

    if (kDebugMode) {
      print(id);
    }
    return id;
  }

  late final FindIdRepo _repository;
}

final findIdProvider = AsyncNotifierProvider<FindIdViewModel, void>(
  () => FindIdViewModel(),
);
