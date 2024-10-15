import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/messages/models/UserListModel.dart';
import 'package:sbas/features/messages/repos/contact_repo.dart';

class UserListNotifier extends AsyncNotifier<UserListModel> {
  var page = 1;

  @override
  FutureOr<UserListModel> build() async {
    _contactRepository = ref.read(contactRepoProvider);

    return await init();
  }

  Future<UserListModel> init() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      Map<String, dynamic> map = {};
      map['page'] = page;
      return await _contactRepository.getAllUser(map);
    });
    if (state.hasError) {}
    page = 1;
    return state.value ?? UserListModel(items: [], count: 0);
  }

  Future<UserListModel> updateUserList() async {
    if (state.isLoading) return state.value ?? UserListModel(items: [], count: 0);

    page++;
    if (page <= 1) {
      return await init();
    }
    Map<String, dynamic> map = {};
    map['page'] = page;
    // 기존 상태를 유지하면서 로딩 상태로 변경
    state = AsyncValue.data(state.value!);

    // API 호출 및 데이터 병합
    state = await AsyncValue.guard(() async {
      final newUserList = await _contactRepository.getAllUser(map);
      if (state.value != null && newUserList.items.isNotEmpty) {
        // 기존 리스트에 새로 가져온 데이터 추가
        state.value!.items.addAll(newUserList.items);
        state.value!.count = newUserList.count; // count 업데이트
        return state.value!;
      }

      if(newUserList.items.isEmpty) {
        //다음 데이터가 없을 경우 기존데이터 반환
        return state.value!;
      }
      return newUserList; // 기존 데이터가 없을 때는 새로운 리스트로 교체
    });

    if (state.hasError) {
      // 에러 처리 로직 추가 가능
    }

    // state.value가 없으면 빈 리스트를 가진 기본 PatientListModel 반환
    return state.value ?? UserListModel(items: [], count: 0);
  }

  late final ContactRepository _contactRepository;
}

final userListProvider =
AsyncNotifierProvider<UserListNotifier, UserListModel>(
      () => UserListNotifier(),
);
final selectedUserIdProvider = StateProvider<List<String>>((ref) => []);
final selectedUserNmProvider = StateProvider<List<String>>((ref) => []);