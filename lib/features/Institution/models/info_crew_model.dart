import 'dart:convert';

class InfoCrew {
  String instId;
  int crewId;
  String crewNm;
  String? telno;
  String? rmk;
  String? pstn;

  InfoCrew({
    required this.instId,
    required this.crewId,
    required this.crewNm,
    this.telno,
    this.rmk,
    this.pstn,
  });

  factory InfoCrew.fromRawJson(String str) => InfoCrew.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfoCrew.fromJson(Map<String, dynamic> json) => InfoCrew(
    instId: json["instId"],
    crewId: json["crewId"],
    crewNm: json["crewNm"],
    telno: json["telno"],
    rmk: json["rmk"],
    pstn: json["pstn"],
  );

  Map<String, dynamic> toJson() => {
    "instId": instId,
    "crewId": crewId,
    "crewNm": crewNm,
    "telno": telno,
    "rmk": rmk,
    "pstn": pstn,
  };
}
