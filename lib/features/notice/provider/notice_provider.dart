import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/notice/models/read_notice_request_model.dart';
import 'package:sbas/features/notice/repos/notice_repo.dart';
import 'package:sbas/features/notice/models/notice_detail_model.dart';
import 'package:sbas/features/notice/models/notice_list_model.dart';
import 'package:sbas/features/notice/models/notice_list_request_model.dart';

class NoticeNotifier extends AsyncNotifier {
  late final NoticeRepository _repository;
  NoticeListModel listModel = NoticeListModel(items: []);
  @override
  FutureOr build() async {
    _repository = ref.read(noticeRepoProvider);
  }

  Future<void> getNoticeList(NoticeListRequestModel model) async {
    await _repository.getNoticeList(model).then((value) => listModel = value);
  }

  Future<NoticeDetailModel> getNoticeDetail(String noticeId) async {
    return await _repository.getNoticeDetail(noticeId);
  }

  Future<void> readNotice(ReadNoticeRequestModel request) async {
    await _repository.readNotice(request);
  }

}

final noticeProvider =
AsyncNotifierProvider<NoticeNotifier, void>(
      () => NoticeNotifier(),
);
