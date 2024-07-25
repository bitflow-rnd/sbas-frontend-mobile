class ModifyPwModel {
  String id;
  String modifyPw;

  ModifyPwModel({
    required this.id,
    required this.modifyPw,
  });

  factory ModifyPwModel.fromJson(Map<String, dynamic> json) {
    return ModifyPwModel(
      id: json['id'],
      modifyPw: json['modifyPw'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modifyPw': modifyPw,
    };
  }
}