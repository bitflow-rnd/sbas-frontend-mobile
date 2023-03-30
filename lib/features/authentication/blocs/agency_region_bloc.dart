import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class AgencyRegionBloc extends AsyncNotifier<List<BaseCodeModel>> {
  @override
  FutureOr<List<BaseCodeModel>> build() async {
    _userRegRequestRepository = ref.read(userRegReqProvider);

    list = await _userRegRequestRepository.getBaseCode('SIDO');

    return list;
  }

  Future<void> addCounty() async {
    list.removeWhere((e) =>
        e.id != null && e.id?.cdGrpId != null && e.id!.cdGrpId!.length > 4);

    final region = ref.read(selectedRegionProvider);

    list.addAll(await _userRegRequestRepository
        .getBaseCode('${region.id?.cdGrpId}${region.id?.cdId}'));
  }

  late final List<BaseCodeModel> list;

  late final UserRegRequestRepository _userRegRequestRepository;
}

final agencyRegionProvider =
    AsyncNotifierProvider<AgencyRegionBloc, List<BaseCodeModel>>(
  () => AgencyRegionBloc(),
);

final selectedRegionProvider =
    StateProvider<BaseCodeModel>((ref) => BaseCodeModel());

final selectedCountyProvider =
    StateProvider<BaseCodeModel>((ref) => BaseCodeModel());
