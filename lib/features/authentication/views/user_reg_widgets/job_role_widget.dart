import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/field_error_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/job_role_bloc.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/affiliation_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/auth_group_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/detail_auth_widget.dart';
import 'package:sbas/constants/palette.dart';

class JobRole extends ConsumerStatefulWidget {
  const JobRole({
    required this.detailAuthTitles,
    required this.detailAuthSubTitles,
    required this.authGroupSubTitles,
    required this.authGroupSelectedImages,
    required this.authGroupDisabledImages,
    required this.authGroupTitles,
    required this.title,
    super.key,
  });
  final List<String> title, authGroupSelectedImages, authGroupDisabledImages, authGroupTitles, authGroupSubTitles, detailAuthTitles, detailAuthSubTitles;

  @override
  ConsumerState<JobRole> createState() => _JobRoleState();
}

class _JobRoleState extends ConsumerState<JobRole> {
  final authGroupCode = [
    'PMGR0001',
    'PMGR0002',
    'PMGR0003',
    'PMGR0004',
  ];

  final detailAuthCode = ['DTPM0001', 'DTPM0002'];

  Widget _getTitie(int index) => Row(
        children: [
          Text(
            widget.title[index],
            style: CTS.bold(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          Text(
            '(필수)',
            style: CTS.bold(
              fontSize: 13,
              color: Palette.mainColor,
            ),
          ),
        ],
      );
  int affiliationSelectedIndex = -1, authGroupSelectedIndex = -1, detailAuthSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(regUserProvider);

    final instTypeCd = model.instTypeCd;
    final jobCd = model.jobCd;
    final authCd = model.authCd;

    return ref.watch(jobRoleProvider).when(
          loading: () => const SBASProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: CTS(
                color: Palette.mainColor,
              ),
            ),
          ),
          data: (data) {
            if (authCd != null && authCd.isNotEmpty) {
              detailAuthSelectedIndex = detailAuthCode.indexOf(authCd);
            }
            if (jobCd != null && jobCd.isNotEmpty) {
              authGroupSelectedIndex = authGroupCode.indexOf(jobCd);
            }
            if (instTypeCd != null && instTypeCd.isNotEmpty) {
              affiliationSelectedIndex = data.indexWhere((element) => element.cdId == instTypeCd);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  _getTitie(0),
                  FormField(
                    initialValue: instTypeCd,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value == null || value.isEmpty ? '소속기관 유형을 선택해주세요.' : null,
                    builder: (field) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 128,
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            itemCount: data.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 24,
                              childAspectRatio: 2.5,
                            ),
                            itemBuilder: (context, index) => Affiliation(
                              title: data[index].cdNm ?? '',
                              index: index,
                              selectedIndex: affiliationSelectedIndex,
                              onChanged: (value) => setState(
                                () {
                                  affiliationSelectedIndex = value ?? 0;

                                  model.instTypeCd = data[affiliationSelectedIndex].cdId;

                                  field.didChange(model.instTypeCd);
                                },
                              ),
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        if (field.hasError)
                          FieldErrorText(
                            field: field,
                          )
                      ],
                    ),
                  ),
                  _getTitie(1),
                  FormField(
                    initialValue: jobCd,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value == null || value.isEmpty ? '권한그룹을 선택해주세요.' : null,
                    builder: (field) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 128 * 3 + 8,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                            itemCount: widget.authGroupTitles.length,
                            itemBuilder: (context, index) => AuthorizationGroup(
                              selectedIndex: authGroupSelectedIndex,
                              index: index,
                              disabledImage: widget.authGroupDisabledImages[index],
                              selectedImage: widget.authGroupSelectedImages[index],
                              title: widget.authGroupTitles[index],
                              subTitle: widget.authGroupSubTitles[index],
                              onChanged: (value) => setState(
                                () {
                                  authGroupSelectedIndex = value ?? 0;

                                  model.jobCd = authGroupCode[index];

                                  field.didChange(model.jobCd);
                                },
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        if (field.hasError)
                          FieldErrorText(
                            field: field,
                          )
                      ],
                    ),
                  ),
                  _getTitie(2),
                  FormField(
                    initialValue: authCd,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value == null || value.isEmpty ? '권한을 선택해주세요.' : null,
                    builder: (field) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 128,
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            itemCount: widget.detailAuthTitles.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 16,
                              childAspectRatio: 8.75 / 1,
                            ),
                            itemBuilder: (context, index) => DetailAuthorization(
                              title: widget.detailAuthTitles[index],
                              subTitle: widget.detailAuthSubTitles[index],
                              index: index,
                              selectedIndex: detailAuthSelectedIndex,
                              onChanged: (value) => setState(
                                () {
                                  detailAuthSelectedIndex = value ?? 0;

                                  model.authCd = detailAuthCode[index];

                                  field.didChange(model.authCd);
                                },
                              ),
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        if (field.hasError)
                          FieldErrorText(
                            field: field,
                          )
                      ],
                    ),
                  ),
                  Gaps.v52
                ],
              ),
            );
          },
        );
  }
}
