import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/notice/api/notice_provider.dart';
import 'package:sbas/features/notice/models/active_notice_request_model.dart';
import 'package:sbas/features/notice/models/notice_list_request_model.dart';
import 'package:sbas/features/notice/models/read_notice_request_model.dart';
import 'package:sbas/features/notice/models/reg_notice_request_model.dart';

import '../models/info_notice_model.dart';
import '../models/notice_detail_model.dart';
import '../models/notice_list_model.dart';

class NoticeRepository {
  Future<NoticeListModel> getNoticeList(NoticeListRequestModel model) async =>
      await _noticeProvider.getNoticeList(model.toJson());

  Future<NoticeDetailModel> getNoticeDetail(String noticeId) async =>
      await _noticeProvider.getNoticeDetail(noticeId);

  Future<dynamic> readNotice(ReadNoticeRequestModel model) async =>
      await _noticeProvider.readNotice(model.toJson());

  Future<dynamic> regNotice(RegNoticeRequestModel model) async =>
      await _noticeProvider.regNotice(model.toJson());

  Future<dynamic> modNotice(InfoNoticeModel model) async =>
      await _noticeProvider.modNotice(model.toJson());

  Future<dynamic> delNotice(String noticeId) async =>
      await _noticeProvider.delNotice({'noticeId': noticeId});

  Future<dynamic> activeNotice(ActiveNoticeRequestModel model) async =>
      await _noticeProvider.activeNotice(model.toJson());


  final _noticeProvider = NoticeProvider();
}

final noticeRepoProvider = Provider(
  (ref) => NoticeRepository(),
);