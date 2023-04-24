import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/models/base_code_model.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/lookup/blocs/severely_disease_presenter.dart';

class SeverelyDisease extends ConsumerStatefulWidget {
  SeverelyDisease({
    super.key,
  });
  final subTitles = [
    '환자유형',
    '기저질환',
    '중증도 분류',
    '요청 병상유형',
    'DNR 동의 여부',
  ];
  final classification = [
    '직접선택',
    '생체정보 입력분석',
    '알수없음',
  ];
  @override
  ConsumerState<SeverelyDisease> createState() => _SeverelyDiseaseState();
}

class _SeverelyDiseaseState extends ConsumerState<SeverelyDisease> {
  Widget _initClassification(int index) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 18,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Text(
          widget.classification[index],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          maxLines: 1,
        ),
      );

  Widget _initGridView<T>(Iterable<BaseCodeModel> model,
          SliverGridDelegate sliverGridDelegate) =>
      GridView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        gridDelegate: sliverGridDelegate,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            final key = model.toList()[index].id?.cdId;

            if (key != null && key.isNotEmpty) {
              final isChecked = ref.watch(checkedSeverelyDiseaseProvider)[key];

              if (isChecked != null) {
                setState(() => ref
                    .read(checkedSeverelyDiseaseProvider.notifier)
                    .state[key] = !isChecked);
              }
            }
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey,
                  style: ref.watch(checkedSeverelyDiseaseProvider)[
                              model.toList()[index].id?.cdId] ==
                          true
                      ? BorderStyle.none
                      : BorderStyle.solid),
              color: ref.watch(checkedSeverelyDiseaseProvider)[
                          model.toList()[index].id?.cdId] ==
                      true
                  ? Colors.lightBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(
                18,
              ),
            ),
            child: Text(
              model.toList()[index].cdNm ?? '',
              style: TextStyle(
                color: ref.watch(checkedSeverelyDiseaseProvider)[
                            model.toList()[index].id?.cdId] ==
                        true
                    ? Colors.white
                    : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
            ),
          ),
        ),
        itemCount: model.length,
        physics: const NeverScrollableScrollPhysics(),
      );
  @override
  Widget build(BuildContext context) => ref.watch(severelyDiseaseProvider).when(
        loading: () => const SBASProgressIndicator(),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        data: (model) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < widget.subTitles.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v2,
                      Text(
                        '${i + 1}.${widget.subTitles[i]}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      if (i == 2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < widget.classification.length;
                                      i++)
                                    _initClassification(i),
                                ],
                              ),
                            ),
                            Gaps.v6,
                            const Text(
                              '중증도 분석 결과',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      if (i == 0)
                        SizedBox(
                          height: _getHeight(
                            model.where((e) => e.id?.cdGrpId == 'PTTP'),
                            4,
                          ),
                          child: _initGridView(
                            model.where((e) => e.id?.cdGrpId == 'PTTP'),
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.925,
                            ),
                          ),
                        )
                      else if (i == 1)
                        SizedBox(
                          height: _getHeight(
                            model.where((e) => e.id?.cdGrpId == 'UDDS'),
                            3,
                          ),
                          child: _initGridView(
                            model.where((e) => e.id?.cdGrpId == 'UDDS'),
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.325,
                            ),
                          ),
                        )
                      else if (i == 2)
                        SizedBox(
                          height: _getHeight(
                            model.where((e) => e.id?.cdGrpId == 'SVTP'),
                            4,
                          ),
                          child: _initGridView(
                            model.where((e) => e.id?.cdGrpId == 'SVTP'),
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.925,
                            ),
                          ),
                        )
                      else if (i == 3)
                        SizedBox(
                          height: _getHeight(
                            model.where((e) => e.id?.cdGrpId == 'BDTP'),
                            4,
                          ),
                          child: _initGridView(
                            model.where((e) => e.id?.cdGrpId == 'BDTP'),
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.925,
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: _getHeight(
                            model.where((e) => e.id?.cdGrpId == 'DNRA'),
                            4,
                          ),
                          child: _initGridView(
                            model.where((e) => e.id?.cdGrpId == 'DNRA'),
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.925,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
  double _getHeight(Iterable<BaseCodeModel> model, int crossAxisCount) =>
      (model.length / crossAxisCount + 1) * 54.h;
}
