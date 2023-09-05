import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class SaftyRegionBloc extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    list = await _userRegRequestRepository.getBaseCode('SIDO');

    return list;
  }

  Future<void> exchangeTheCounty() async {
    list.removeWhere((e) => e.cdGrpId != null && e.cdGrpId!.length > 4);

    state = const AsyncLoading();

    state = await AsyncValue.guard<List<BaseCodeModel>>(
      () async {
        final region = ref.read(selectedRegionProvider);

        list.addAll(await _userRegRequestRepository.getBaseCode('${region.cdGrpId}${region.cdId}'));

        return list;
      },
    );
    if (state.hasError) {}
  }

  Future<void> selectTheCounty(BaseCodeModel region) async {
    list.removeWhere((e) => e.cdGrpId != null && e.cdGrpId!.length > 4);

    state = const AsyncLoading();

    state = await AsyncValue.guard<List<BaseCodeModel>>(
      () async {
        list.addAll(await _userRegRequestRepository.getBaseCode('${region.cdGrpId}${region.cdId}'));

        return list;
      },
    );
    if (state.hasError) {}
  }

  late final List<BaseCodeModel> list;

  late final UserRegRequestRepository _userRegRequestRepository;
}

final saftyRegionPresenter = AsyncNotifierProvider<SaftyRegionBloc, List<BaseCodeModel>>(
  () => SaftyRegionBloc(),
);

final selectedRegionProvider = StateProvider<BaseCodeModel>((ref) => BaseCodeModel());

final selectedCountyProvider = StateProvider<BaseCodeModel>((ref) => BaseCodeModel());
