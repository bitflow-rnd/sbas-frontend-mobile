class NoticeListRequestModel {
  String? userId;
  int? page;
  int? size;
  bool? isActive;
  String? searchPeriod;

  NoticeListRequestModel({
    this.userId,
    this.page,
    this.size,
    this.isActive,
    this.searchPeriod
  });

  void clear() {
    userId = null;
    page = null;
    size = null;
    isActive = null;
    searchPeriod = null;
  }

  NoticeListRequestModel.fromJson(Map<String, dynamic> json) {
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["page"] is int) {
      page = json["page"];
    }
    if (json["size"] is int) {
      size = json["size"];
    }
    if (json["isActive"] is bool) {
      isActive = json["isActive"];
    }
    if (json["searchPeriod"] is String) {
      searchPeriod = json["searchPeriod"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["userId"] = userId;
    data["page"] = page;
    data["size"] = size;
    data["isActive"] = isActive;
    data["searchPeriod"] = searchPeriod;

    return data;
  }
}