import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/notice/models/read_notice_request_model.dart';
import 'package:sbas/features/notice/repos/notice_repo.dart';
import 'package:sbas/features/notice/models/notice_detail_model.dart';
import 'package:sbas/features/notice/models/notice_list_model.dart';
import 'package:sbas/features/notice/models/notice_list_request_model.dart';

class NoticePresenter extends AsyncNotifier {
  late final NoticeRepository _repository;

  @override
  FutureOr build() async {
    _repository = ref.read(noticeRepoProvider);
  }

  Future<void> getNoticeList(NoticeListRequestModel model) async {
    ref.read(noticeListProvider.notifier).state = await _repository.getNoticeList(model);
  }

  Future<NoticeDetailModel> getNoticeDetail(String noticeId) async {
    if(noticeId != null) {
      return await _repository.getNoticeDetail(noticeId);
    }

    return NoticeDetailModel();
  }

  Future<void> readNotice(ReadNoticeRequestModel request) async {
    await _repository.readNotice(request);
  }

}

final noticePresenter =
AsyncNotifierProvider<NoticePresenter, void>(
      () => NoticePresenter(),
);

final noticeListProvider = StateProvider<NoticeListModel?>((ref) => null);
