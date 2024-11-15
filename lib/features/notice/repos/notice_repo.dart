import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/notice/models/active_notice_request_model.dart';
import 'package:sbas/features/notice/models/info_notice_model.dart';
import 'package:sbas/features/notice/models/notice_detail_model.dart';
import 'package:sbas/features/notice/models/notice_list_model.dart';
import 'package:sbas/features/notice/models/notice_list_request_model.dart';
import 'package:sbas/features/notice/models/read_notice_request_model.dart';
import 'package:sbas/features/notice/models/reg_notice_request_model.dart';
import 'package:sbas/util.dart';

class NoticeRepository {
  Future<NoticeListModel> getNoticeList(NoticeListRequestModel model) async =>
      NoticeListModel.fromJson(
          await _api.getAsyncWithMap('$_publicRoute/notice', model.toJson()));

  Future<NoticeDetailModel> getNoticeDetail(String noticeId) async =>
      NoticeDetailModel.fromJson(
          await _api.getAsync('$_publicRoute/notice/$noticeId'));

  Future<dynamic> readNotice(ReadNoticeRequestModel model) async =>
      await _api.postAsync('$_publicRoute/notice', toJson(model.toJson()));

  Future<dynamic> regNotice(RegNoticeRequestModel model) async =>
      await _api.postAsync('$_adminRoute/reg-notice', toJson(model.toJson()));

  Future<dynamic> modNotice(InfoNoticeModel model) async =>
      await _api.postAsync('$_adminRoute/mod-notice', toJson(model.toJson()));

  Future<dynamic> delNotice(String noticeId) async =>
      await _api.postAsync('$_adminRoute/del-notice', toJson({'noticeId': noticeId}));

  Future<dynamic> activeNotice(ActiveNoticeRequestModel model) async =>
      await _api.postAsync('$_adminRoute/active', toJson(model.toJson()));

  final String _adminRoute = 'admin/common';
  final String _publicRoute = 'public/common';
  final _api = V1Provider();
}

final noticeRepoProvider = Provider(
  (ref) => NoticeRepository(),
);
