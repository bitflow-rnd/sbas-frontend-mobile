class JwtModel {
  Token? token;

  JwtModel({this.token});

  JwtModel.fromJson(Map<String, dynamic> json) {
    if (json["token"] is Map) {
      token = json["token"] == null ? null : Token.fromJson(json["token"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (token != null) {
      data["token"] = token?.toJson();
    }
    return data;
  }
}

class Token {
  String? name;
  List<String>? claimNames;
  List<String>? groups;
  dynamic audience;
  String? rawToken;
  String? issuer;
  String? tokenId;
  int? expirationTime;
  int? issuedAtTime;
  dynamic subject;

  Token({
    this.name,
    this.claimNames,
    this.groups,
    this.audience,
    this.rawToken,
    this.issuer,
    this.tokenId,
    this.expirationTime,
    this.issuedAtTime,
    this.subject,
  });

  Token.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["claimNames"] is List) {
      claimNames = json["claimNames"] == null
          ? null
          : List<String>.from(json["claimNames"]);
    }
    if (json["groups"] is List) {
      groups =
          json["groups"] == null ? null : List<String>.from(json["groups"]);
    }
    audience = json["audience"];
    if (json["rawToken"] is String) {
      rawToken = json["rawToken"];
    }
    if (json["issuer"] is String) {
      issuer = json["issuer"];
    }
    if (json["tokenID"] is String) {
      tokenId = json["tokenID"];
    }
    if (json["expirationTime"] is int) {
      expirationTime = json["expirationTime"];
    }
    if (json["issuedAtTime"] is int) {
      issuedAtTime = json["issuedAtTime"];
    }
    subject = json["subject"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    if (claimNames != null) {
      data["claimNames"] = claimNames;
    }
    if (groups != null) {
      data["groups"] = groups;
    }
    data["audience"] = audience;
    data["rawToken"] = rawToken;
    data["issuer"] = issuer;
    data["tokenID"] = tokenId;
    data["expirationTime"] = expirationTime;
    data["issuedAtTime"] = issuedAtTime;
    data["subject"] = subject;
    return data;
  }
}
