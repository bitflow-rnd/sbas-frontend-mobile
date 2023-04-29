import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/models/patient_info_model.dart';


class AssignBedDetailDiseaseInfo extends ConsumerWidget {
  AssignBedDetailDiseaseInfo({
    super.key,
    required this.patient,
  });
  final List<String> list1 = [
    '담당보건소',
    '코로나19증상 및 징후',
    '확진검사결과',
    '질병급',
    '발병일,진단일,신고일', //진단일,신고일 추가
    '환자등 분류',
    '비고', //DNR 동의 추가
    ///////////
  ];

  final List<String> disaeasePatientType = [
    "기저질환", // list
    "환자유형", //list
  ];
  final List<String> list2 = [
    'DNR 동의'
        '입원여부',
    '요양기관 기호.명',
    '요양기관기호',
    '요양기관주소',
    '요양기관 전화번호',
    '진단의사 성명',
    '신고기관장 성명',
    "요청병상유형", //요청병상유형 추가
    '역학조사서, 진료 이미지 및 영상', //기타 진료정보 이미지·영상 에서 변경
  ];

  final List<String> EmrCategory = [
    "중증도 분류", //header
    "체온(℃)",
    "맥박(회/분)",
    "분당호흡수(회/분)",
    "산소포화도(%)",
    "수축기혈압(mmHg)",
  ];
  final Patient patient;
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
                          ? Expanded(
                              flex: 1,
                              child: Text(
                                list1[i],
                                style: CTS(
                                  color: Palette.greyText,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          : Expanded(
                              child: Row(
                                children: [
                                  for (int _ = 0; _ < 3; _++)
                                    Expanded(
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list1[i].split(",")[_],
                                            style: CTS(
                                              color: Palette.greyText,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
                                              child: Text(
                                                '2023.01.01',
                                                style: CTS.medium(
                                                  fontSize: 13,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ))
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                      i != 4
                          ? Expanded(
                              flex: 3,
                              child: Text(
                                getList1Value(i, patient),
                                style: CTS.medium(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ))
                          : Container(),
                    ],
                  ),
                ),
            ],
          ),

          Container(margin: EdgeInsets.symmetric(horizontal: 24.w), height: 1.h, width: double.infinity, color: Palette.greyText_20), //divider

          //second column
          Column(
            children: [
              for (int i = 0; i < disaeasePatientType.length; i++)
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
                          disaeasePatientType[i],
                          style: CTS(
                            color: Palette.greyText,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Row(
                            //wrap 사용하여 개수 유동적 대응
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              for (var disease = 0; disease < 3; disease++)
                                Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Palette.greyText_20,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(13.5),
                                  ),
                                  child: Text(
                                    '기저질환',
                                    style: CTS.medium(fontSize: 13, color: Palette.greyText_80),
                                    textAlign: TextAlign.end,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                            ],
                          ))
                    ],
                  ),
                ),
            ],
          ),
          Container(margin: EdgeInsets.symmetric(horizontal: 24.w), height: 1.h, width: double.infinity, color: Palette.greyText_20), //divider
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
                      EmrCategory[0],
                      style: CTS(
                        color: Palette.greyText,
                        fontSize: 13,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '중증',
                      style: CTS.medium(
                        fontSize: 13,
                      ),
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
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                        child: Column(
                          children: [
                            for (var i = 1; i < 4; i++)
                              Padding(
                                padding: EdgeInsets.only(top: i != 1 ? 12.h : 0),
                                child: Row(
                                  children: [
                                    Text(
                                      EmrCategory[i],
                                      style: CTS(
                                        color: Palette.greyText,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '123',
                                      style: CTS.medium(
                                        fontSize: 13,
                                      ),
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
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                        child: Column(
                          children: [
                            for (var i = 4; i < EmrCategory.length; i++)
                              Padding(
                                padding: EdgeInsets.only(top: i != 4 ? 12.h : 0),
                                child: Row(
                                  children: [
                                    Text(
                                      EmrCategory[i],
                                      style: CTS(
                                        color: Palette.greyText,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '333',
                                      style: CTS.medium(
                                        fontSize: 13,
                                      ),
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

          Container(margin: EdgeInsets.symmetric(horizontal: 24.w), height: 1.h, width: double.infinity, color: Palette.greyText_20), //divider
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
                      Spacer(),
                      Text(
                        getList2Value(i, patient),
                        style: CTS.medium(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
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
                  Expanded(child: Container(padding: EdgeInsets.symmetric(horizontal: 8.w), child: Image.asset("assets/auth_group/image_location.png")))
              ],
            ),
          ),
          Gaps.v32,
        ],
      )),
    );
  }

  String getList1Value(int index, Patient patient) {
    String text = '';
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
        text = "대구 북구 보건소";
        break;

      case 1:
        text = '코로나19감염병';
        break;

      case 2:
        text = '양성';
        break;

      case 3:
        text = "2급";
        break;

      case 4:
        text = "2023.01.02";
        break;

      case 5:
        text = "환자";
        break;

      case 6:
        text = "PCR";
        break;
    }
    return text;
  }

  String getList2Value(int index, Patient patient) {
    String text = '';
// 'DNR 동의' //DNR 동의 추가
//  '입원여부',
//  '요양기관명'*  +('요양기관기호')
//  '요양기관주소',
//  '요양기관 전화번호',
//  '진단의사 성명',
//  '신고기관장 성명',
//  "요청병상유형", //요청병상유형 추가
//  '역학조사서, 진료 이미지 및 영상',
    text = "Data has to be here";
    switch (index) {
      case 0:
        text = "알수없음";
        break;

      case 1:
        text = '입원';
        break;

      case 2:
        text = 'A10378/칠곡경북대병원';
        break;

      case 3:
        text = "대구 북구 호국로 807";
        break;

      case 4:
        text = "044-222-2222";
        break;

      case 5:
        text = "권승구";
        break;

      case 6:
        text = "이재용";
        break;
      case 7:
        text = "음압격리";
        break;
      case 8:
        text = "";
        break;
    }
    return text;
  }
}
