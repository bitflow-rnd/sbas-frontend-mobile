import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/models/patient_disease_info_model.dart';

class AssignBedDetailDiseaseInfo extends ConsumerWidget {
  AssignBedDetailDiseaseInfo({
    super.key,
    required this.ptId,
    required this.diseaseInfo,
  });
  final String? ptId;
  final PatientDiseaseInfoModel diseaseInfo;
  final List<String> list1 = [
    '담당보건소',
    '코로나19증상 및 징후',
    '확진검사결과',
    '질병급',
    '발병일,진단일,신고일',
    '환자등 분류',
    '비고',
  ];
  final List<String> diseasePatientType = [
    "기저질환",
    "환자유형",
  ];
  final List<String> list2 = [
    'DNR 동의',
    '입원여부',
    '요양기관명',
    '요양기관기호',
    '요양기관주소',
    '요양기관 전화번호',
    '진단의사 성명',
    '신고기관장 성명',
    "요청병상유형",
    '역학조사서, 진료 이미지 및 영상',
  ];
  final List<String> emrCategory = [
    "중증도 분류",
    "체온(℃)",
    "맥박(회/분)",
    "분당호흡수(회/분)",
    "산소포화도(%)",
    "수축기혈압(mmHg)",
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //담당보건소~비고
            Column(
              children: [
                for (int i = 0; i < list1.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        i != 4
                            ? Text(
                                list1[i],
                                style: CTS(
                                  color: Palette.greyText,
                                  fontSize: 13,
                                ),
                              )
                            : Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // mainAxisSize: MainAxisSize.max,
                                  children: [
                                    for (int j = 0; j < 3; j++)
                                      Expanded(
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              list1[i].split(",")[j],
                                              style: CTS(
                                                color: Palette.greyText,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 0.w,
                                                vertical: 8.h,
                                              ),
                                              child: Text(
                                                getList1Value(i + 100, diseaseInfo), // 발병일, 진단일, 신고일
                                                style: CTS.medium(fontSize: 13),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                        if (i != 4) const Spacer(),
                        i != 4
                            ? Text(
                                getList1Value(i, diseaseInfo),
                                style: CTS.medium(fontSize: 13),
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container(),
                      ],
                    ),
                  ),
              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              height: 1.h,
              width: double.infinity,
              color: Palette.greyText_20,
            ), //divider

            //second column
            Column(
              children: [
                for (int i = 0; i < diseasePatientType.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            diseasePatientType[i],
                            style: CTS(
                              color: Palette.greyText,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              //wrap 사용하여 개수 유동적 대응
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (i == 0)
                                  for (var disease = 0; disease < diseaseInfo.undrDsesNms.length; disease++)
                                    Container(
                                      margin: EdgeInsets.only(right: 8.w),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Palette.greyText_20,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(13.5),
                                      ),
                                      child: Text(
                                        diseaseInfo.undrDsesNms[disease],
                                        style: CTS.medium(
                                          fontSize: 13,
                                          color: Palette.greyText_80,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                else if (i == 1)
                                  for (var innerIndex = 0; innerIndex < diseaseInfo.ptTypeNms.length; innerIndex++)
                                    Container(
                                      margin: EdgeInsets.only(right: 8.w),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Palette.greyText_20,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(13.5),
                                      ),
                                      child: Text(
                                        diseaseInfo.ptTypeNms[innerIndex],
                                        style: CTS.medium(
                                          fontSize: 13,
                                          color: Palette.greyText_80,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              height: 1.h,
              width: double.infinity,
              color: Palette.greyText_20,
            ), //divider
            //EmrCategory
            Gaps.v12,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        emrCategory[0],
                        style: CTS(
                          color: Palette.greyText,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        getEmrCategory(0, diseaseInfo),
                        style: CTS.medium(fontSize: 13),
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 24.h,
                          ),
                          child: Column(
                            children: [
                              for (var i = 1; i < 4; i++)
                                Padding(
                                  padding: EdgeInsets.only(top: i != 1 ? 12.h : 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        emrCategory[i],
                                        style: CTS(
                                          color: Palette.greyText,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        getEmrCategory(i, diseaseInfo),
                                        style: CTS.medium(fontSize: 13),
                                        textAlign: TextAlign.end,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 24.h,
                          ),
                          child: Column(
                            children: [
                              for (var i = 4; i < emrCategory.length; i++)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: i != 4 ? 12.h : 0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        emrCategory[i],
                                        style: CTS(
                                          color: Palette.greyText,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        getEmrCategory(i, diseaseInfo),
                                        style: CTS.medium(fontSize: 13),
                                        textAlign: TextAlign.end,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              height: 1.h,
              width: double.infinity,
              color: Palette.greyText_20,
            ), //divider
            Column(
              children: [
                for (int i = 0; i < list2.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          list2[i],
                          style: CTS(
                            color: Palette.greyText,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          getList2Value(i, diseaseInfo),
                          style: CTS.medium(fontSize: 13),
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Image.asset(
                          "assets/auth_group/image_location.png",
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Gaps.v32,
          ],
        ),
      ),
    );
  }

  String getList1Value(int index, PatientDiseaseInfoModel diseaseInfo) {
    String text = '';
    String defaultText = '-';
// '담당보건소',
//  '코로나19증상 및 징후',
//  '확진검사결과',
//  '질병급',
//  '발병일',//진단일,신고일 추가
//  '진단일',
//  '신고일',
//  '환자등 분류',
//  '비고',
    text = "Data has to be here";
    switch (index) {
      case 0:
        text = diseaseInfo.rcptPhc ?? defaultText;
        break;

      case 1:
        text = diseaseInfo.diagNm ?? defaultText;
        break;

      case 2:
        text = diseaseInfo.dfdgExamRslt ?? defaultText;
        break;

      case 3:
        text = diseaseInfo.diagGrde ?? defaultText;
        break;

      case 104:
        text = diseaseInfo.occrDt ?? defaultText;
        break;
      case 105:
        text = diseaseInfo.diagDt ?? defaultText;
        break;
      case 106:
        text = diseaseInfo.rptDt ?? defaultText;
        break;

      case 5:
        text = diseaseInfo.ptCatg ?? defaultText;
        break;

      case 6:
        text = diseaseInfo.rmk ?? defaultText;
        break;
    }
    return text;
  }

  String getList2Value(int index, PatientDiseaseInfoModel diseaseInfo) {
    var text = '';
    var defaultText = '-';

    switch (index) {
      case 0:
        text = diseaseInfo.dnrAgreYn ?? defaultText;
        break;

      case 1:
        text = diseaseInfo.admsYn ?? defaultText;
        break;

      case 2:
        text = diseaseInfo.instNm ?? defaultText;
        break;

      case 3:
        text = diseaseInfo.instId ?? defaultText;
        break;

      case 4:
        text = "대구 북구 호국로 807"; //TODO 주소 길이 너무 길면 오류
        break;

      case 5:
        text = diseaseInfo.instTelno ?? defaultText;
        break;

      case 6:
        text = diseaseInfo.diagDrNm ?? defaultText;
        break;

      case 7:
        text = diseaseInfo.rptChfNm ?? defaultText;
        break;

      case 8:
        text = diseaseInfo.reqBedTypeNm ?? defaultText;
        break;
    }
    return text;
  }

  String getEmrCategory(int index, PatientDiseaseInfoModel diseaseInfo) {
    String text = '';
    String defaultText = '-';

    switch (index) {
      case 0:
        text = diseaseInfo.svrtTypeNms[0];
        break;

      case 1:
        text = (diseaseInfo.bdtp ?? defaultText).toString();
        break;

      case 2:
        text = (diseaseInfo.hr ?? defaultText).toString();
        break;

      case 3:
        text = (diseaseInfo.resp ?? defaultText).toString();
        break;

      case 4:
        text = (diseaseInfo.spo2 ?? defaultText).toString();
        break;

      case 5:
        text = (diseaseInfo.sbp ?? defaultText).toString();
        break;
    }

    return text;
  }
}
