import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/repos/login_repo.dart';

class UserDetailBloc extends AsyncNotifier<UserDetailModel> {
  late final LoginRepo _repository;
  late final UserDetailModel _user;

  @override
  FutureOr<UserDetailModel> build() async {
    _repository = ref.read(authRepo);
    // _user =
    // userId = ref.read(loginProvider.notifier).userId;
    _user = UserDetailModel();

    return _user;
  }

  get userNm => _user.userNm;
  get instNm => _user.instNm;
  get userId => _user.id;
  get instId => _user.instId;
  get jobCd => _user.jobCd;
  get instTypeCd => _user.instTypeCd;
  get dutyDstr2Cd => _user.dutyDstr2Cd;
  logout() {
    _user.clear();
  }

  getUserDetails(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      UserDetailModel? u = await _repository.getUserDetail(id);

      if (u != null) {
        _user.id = u.id;

        _user.userNm = u.userNm;
        _user.instNm = u.instNm;
        _user.instId = u.instId;
        _user.jobCd = u.jobCd;
        _user.instTypeCd = u.instTypeCd;
        _user.dutyDstr2Cd = u.dutyDstr2Cd;
        print('id: ${u.id}, instNm: ${u.instNm}, instId: ${u.instId}, jobCd: ${u.jobCd}, instTypeCd: ${u.instTypeCd}');

        _user.id = u.id ?? "";
      }

      return _user;
    });
  }
}

final userDetailProvider =
    AsyncNotifierProvider<UserDetailBloc, UserDetailModel>(
  () => UserDetailBloc(),
);
