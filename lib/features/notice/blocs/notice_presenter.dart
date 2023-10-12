import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/notice/repos/notice_repo.dart';

import '../models/notice_detail_model.dart';
import '../models/notice_list_model.dart';
import '../models/notice_list_request_model.dart';

class NoticePresenter extends AsyncNotifier {
  late final NoticeRepository _repository;

  @override
  FutureOr build() async {
    _repository = ref.read(noticeRepoProvider);
  }

  Future<NoticeListModel> getNoticeList(NoticeListRequestModel model) async {
    if(model != null) {
      return await _repository.getNoticeList(model);
    }

    return NoticeListModel(items: List.empty());
  }

  Future<NoticeDetailModel> getNoticeDetail(String noticeId) async {
    if(noticeId != null) {
      return await _repository.getNoticeDetail(noticeId);
    }

    return NoticeDetailModel();
  }

}

final noticePresenter =
AsyncNotifierProvider<NoticePresenter, void>(
      () => NoticePresenter(),
);
