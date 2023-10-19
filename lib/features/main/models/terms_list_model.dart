import 'package:sbas/features/main/models/terms_list_id_model.dart';

class TermsListModel {
  late TermsListIdModel id;
  late String termsName;
  late String detail;
  late String rgstUserId;
  late String rgstDttm;
  late String updtUserId;
  late String updtDttm;

  TermsListModel({
    required this.id,
    required this.termsName,
    required this.detail,
    required this.rgstUserId,
    required this.rgstDttm,
    required this.updtUserId,
    required this.updtDttm,
  });

  factory TermsListModel.fromJson(Map<String, dynamic> json) {
    return TermsListModel(
      id: TermsListIdModel.fromJson(json['id']),
      termsName: json['termsName'],
      detail: json['detail'],
      rgstUserId: json['rgstUserId'],
      rgstDttm: json['rgstDttm'],
      updtUserId: json['updtUserId'],
      updtDttm: json['updtDttm'],
    );
  }

  static List<TermsListModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => TermsListModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'termsName': termsName,
      'detail': detail,
      'rgstUserId': rgstUserId,
      'rgstDttm': rgstDttm,
      'updtUserId': updtUserId,
      'updtDttm': updtDttm,
    };
  }
}