class TermsDetailModel{
  late String termsType;
  late String termsName;
  late String termsVersion;
  late String detail;
  late String effectiveDt;

  TermsDetailModel({
    required this.termsType,
    required this.termsName,
    required this.termsVersion,
    required this.detail,
    required this.effectiveDt,
  });

  factory TermsDetailModel.fromJson(Map<String, dynamic> json) {
    return TermsDetailModel(
      termsType: json['termsType'],
      termsName: json['termsName'],
      termsVersion: json['termsVersion'],
      detail: json['detail'],
      effectiveDt: json['effectiveDt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'termsType': termsType,
      'termsName': termsName,
      'termsVersion': termsVersion,
      'detail': detail,
      'effectiveDt': effectiveDt,
    };
  }
}