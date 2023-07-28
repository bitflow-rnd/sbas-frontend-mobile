import 'package:sbas/features/lookup/models/origin_info_model.dart';
import 'package:sbas/features/lookup/models/severely_disease_model.dart';

class BedAssignRequestModel {
  SeverelyDiseaseModel? severelyDiseaseModel;
  OriginInfoModel? originInfoModel;


  BedAssignRequestModel(this.severelyDiseaseModel, this.originInfoModel);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["svrInfo"] = severelyDiseaseModel?.toJson();
    data["dprtInfo"] = originInfoModel?.toJson();

    return data;
  }
}