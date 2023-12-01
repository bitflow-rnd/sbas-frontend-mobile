import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/blocs/agency_region_bloc.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';
import 'package:sbas/features/authentication/models/info_inst_model.dart';
import 'package:sbas/features/authentication/repos/user_reg_req_repo.dart';

class AgencyDetailBloc extends AsyncNotifier<List<InfoInstModel>> {
  @override
  FutureOr<List<InfoInstModel>> build() async {
    _infoInstRepository = ref.read(userRegReqProvider);

    list = await _infoInstRepository.getOrganCode('', '', '');

    return list;
  }

  Future<void> exchangeTheAgency() async {
    list.clear();

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final region = ref.read(selectedRegionProvider);
      final county = ref.read(selectedCountyProvider);

      final user = ref.read(regUserProvider);

      list.addAll(await _infoInstRepository.getOrganCode(
          user.instTypeCd, region.cdId, county.cdId));

      return list;
    });
    if (state.hasError) {
      if (kDebugMode) {
        print(state.error);
      }
    }
  }

  Future<void> updatePublicHealthCenter(String id) async {
    list.clear();

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      list.addAll(await _infoInstRepository.getOrganCode('ORGN0003', id, null));

      return list;
    });
    if (state.hasError) {
      if (kDebugMode) {
        print(state.error);
      }
    }
  }

  List<InfoInstModel> list = [];

  late final UserRegRequestRepository _infoInstRepository;
}

final agencyDetailProvider =
    AsyncNotifierProvider<AgencyDetailBloc, List<InfoInstModel>>(
  () => AgencyDetailBloc(),
);
final selectedAgencyProvider = StateProvider<InfoInstModel>(
  (ref) => InfoInstModel(),
);
