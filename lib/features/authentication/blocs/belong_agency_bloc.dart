import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/models/belong_agency_model.dart';

class BelongAgencyBloc extends AsyncNotifier<BelongAgencyModel> {
  @override
  FutureOr<BelongAgencyModel> build() {
    return BelongAgencyModel.isDebugging();
  }

  String? currentSelectedItem;
}

final belongAgencyProvider =
    AsyncNotifierProvider<BelongAgencyBloc, BelongAgencyModel>(
  () => BelongAgencyBloc(),
);
