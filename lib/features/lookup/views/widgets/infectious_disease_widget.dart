import 'package:flutter/material.dart';

class InfectiousDisease extends StatelessWidget {
  InfectiousDisease({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < _titles.length; i++)
            Text('${(i + 1)}.${_titles[i]}'),
        ],
      ),
    );
  }

  final _titles = [
    '담당보건소',
    '코로나19증상 및 징후',
    '확진검사결과',
    '질병급',
    '발병일',
    '환자등 분류',
    '비고',
    '입원여부',
    '요양기관명',
    '요양기관기호',
    '요양기관주소',
    '요양기관 전화번호',
    '진단의사 성명',
    '신고기관장 성명',
    '기타 진료정보 이미지·영상',
  ];
}
