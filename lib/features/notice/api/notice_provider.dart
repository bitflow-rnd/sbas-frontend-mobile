import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/util.dart';
import 'package:sbas/features/notice/models/notice_detail_model.dart';
import 'package:sbas/features/notice/models/notice_list_model.dart';

class NoticeProvider {
  Future<NoticeListModel> getNoticeList(Map<String, dynamic> map) async =>
      NoticeListModel.fromJson(
          await _api.getAsyncWithJson('$_publicRoute/notice', toJson(map)));

  Future<NoticeDetailModel> getNoticeDetail(String noticeId) async =>
      NoticeDetailModel.fromJson(
          await _api.getAsync('$_publicRoute/notice/$noticeId'));

  Future<dynamic> readNotice(Map<String, dynamic> map) async =>
      await _api.postAsync('$_publicRoute/notice', toJson(map));

  Future<dynamic> regNotice(Map<String, dynamic> map) async =>
      await _api.postAsync('$_adminRoute/reg-notice', toJson(map));

  Future<dynamic> modNotice(Map<String, dynamic> map) async =>
      await _api.postAsync('$_adminRoute/mod-notice', toJson(map));

  Future<dynamic> delNotice(Map<String, dynamic> map) async =>
      await _api.postAsync('$_adminRoute/del-notice', toJson(map));

  Future<dynamic> activeNotice(Map<String, dynamic> map) async =>
      await _api.postAsync('$_adminRoute/active', toJson(map));

  final String _adminRoute = 'admin/common';

  final String _publicRoute = 'public/common';

  final _api = V1Provider();
}