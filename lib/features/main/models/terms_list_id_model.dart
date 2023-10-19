class TermsListIdModel {
  late String termsType;
  late String termsVersion;
  late String effectiveDt;

  TermsListIdModel({
    required this.termsType,
    required this.termsVersion,
    required this.effectiveDt,
  });

  factory TermsListIdModel.fromJson(Map<String, dynamic> json) {
    final formattedEffectiveDt = json['effectiveDt'] as String;

    return TermsListIdModel(
      termsType: json['termsType'],
      termsVersion: json['termsVersion'],
      effectiveDt: formattedEffectiveDt,
    );
  }

  String formattedEffectiveDt() {
    final dateTime = DateTime.parse(effectiveDt);
    final formattedDate = '시행일 ${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')}';
    return formattedDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'termsType': termsType,
      'termsVersion': termsVersion,
      'effectiveDt': effectiveDt,
    };
  }
}