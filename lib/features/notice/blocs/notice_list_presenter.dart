import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/notice/repos/notice_repo.dart';

import '../models/notice_list_model.dart';
import '../models/notice_list_request_model.dart';

class NoticeListPresenter extends AsyncNotifier<NoticeListModel> {
  late final NoticeListModel _noticeList;

  @override
  FutureOr<NoticeListModel> build() {
    _repository = ref.read(noticeRepoProvider);

    _noticeList = NoticeListModel(items: []);

    return _noticeList;
  }

  Future<void> getAsync(NoticeListRequestModel model) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _noticeList = await _repository.getNoticeList(model);

      return _noticeList;
    });
  }

  late final NoticeRepository _repository;
}

final noticeListPresenter = AsyncNotifierProvider<NoticeListPresenter, NoticeListModel>(
    () => NoticeListPresenter(),
);