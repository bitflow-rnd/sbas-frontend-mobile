class UserDetailModel {
  String? id;
  String? userNm;
  String? gndr;
  String? telno;
  String? jobCd;
  String? ocpCd;
  String? ptTypeCd;
  String? instTypeCd;
  String? instId;
  String? instNm;
  String? dutyDstr1Cd;
  String? dutyDstr1CdNm;
  String? dutyDstr2Cd;
  String? dutyDstr2CdNm;
  String? btDt;
  String? authCd;
  String? attcId;
  String? userStatCd;
  String? userStatCdNm;
  String? rgstDttm;
  String? updtDttm;
  String? aprvDttm;
  String? jobCdNm;
  String? authCdNm;
  String? instTypeCdNm;
  bool? isFavorite;
  List<String>? ptTypeCdNm;

  UserDetailModel(
      {this.id,
        this.userNm,
        this.gndr,
        this.telno,
        this.jobCd,
        this.ocpCd,
        this.ptTypeCd,
        this.instTypeCd,
        this.instId,
        this.instNm,
        this.dutyDstr1Cd,
        this.dutyDstr1CdNm,
        this.dutyDstr2Cd,
        this.dutyDstr2CdNm,
        this.btDt,
        this.authCd,
        this.attcId,
        this.userStatCd,
        this.userStatCdNm,
        this.rgstDttm,
        this.updtDttm,
        this.aprvDttm,
        this.jobCdNm,
        this.authCdNm,
        this.instTypeCdNm,
        this.isFavorite,
        this.ptTypeCdNm});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userNm = json['userNm'];
    gndr = json['gndr'];
    telno = json['telno'];
    jobCd = json['jobCd'];
    ocpCd = json['ocpCd'];
    ptTypeCd = json['ptTypeCd'];
    instTypeCd = json['instTypeCd'];
    instId = json['instId'];
    instNm = json['instNm'];
    dutyDstr1Cd = json['dutyDstr1Cd'];
    dutyDstr1CdNm = json['dutyDstr1CdNm'];
    dutyDstr2Cd = json['dutyDstr2Cd'];
    dutyDstr2CdNm = json['dutyDstr2CdNm'];
    btDt = json['btDt'];
    authCd = json['authCd'];
    attcId = json['attcId'];
    userStatCd = json['userStatCd'];
    userStatCdNm = json['userStatCdNm'];
    rgstDttm = json['rgstDttm'];
    updtDttm = json['updtDttm'];
    aprvDttm = json['aprvDttm'];
    jobCdNm = json['jobCdNm'];
    authCdNm = json['authCdNm'];
    instTypeCdNm = json['instTypeCdNm'];
    isFavorite = json['isFavorite'];
    ptTypeCdNm = (json['ptTypeCdNm'] as List?)?.map((e) => e as String).toList() ?? [];;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userNm'] = userNm;
    data['gndr'] = gndr;
    data['telno'] = telno;
    data['jobCd'] = jobCd;
    data['ocpCd'] = ocpCd;
    data['ptTypeCd'] = ptTypeCd;
    data['instTypeCd'] = instTypeCd;
    data['instId'] = instId;
    data['instNm'] = instNm;
    data['dutyDstr1Cd'] = dutyDstr1Cd;
    data['dutyDstr1CdNm'] = dutyDstr1CdNm;
    data['dutyDstr2Cd'] = dutyDstr2Cd;
    data['dutyDstr2CdNm'] = dutyDstr2CdNm;
    data['btDt'] = btDt;
    data['authCd'] = authCd;
    data['attcId'] = attcId;
    data['userStatCd'] = userStatCd;
    data['userStatCdNm'] = userStatCdNm;
    data['rgstDttm'] = rgstDttm;
    data['updtDttm'] = updtDttm;
    data['aprvDttm'] = aprvDttm;
    data['jobCdNm'] = jobCdNm;
    data['authCdNm'] = authCdNm;
    data['instTypeCdNm'] = instTypeCdNm;
    data['isFavorite'] = isFavorite;
    data['ptTypeCdNm'] = ptTypeCdNm;
    return data;
  }
}
