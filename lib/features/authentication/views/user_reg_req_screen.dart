import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/features/authentication/blocs/user_reg_req_bloc.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/belong_agency_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/job_role_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/self_auth_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/top_navbar_req_widget.dart';

class UserRegisterRequestScreen extends ConsumerStatefulWidget {
  const UserRegisterRequestScreen({
    super.key,
  });

  @override
  ConsumerState<UserRegisterRequestScreen> createState() =>
      UserRegisterRequestScreenState();
}

class UserRegisterRequestScreenState
    extends ConsumerState<UserRegisterRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final index = ref.watch(regIndexProvider);

    return ref.watch(userRegProvider).when(
          loading: () => const CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(
              Colors.lightBlueAccent,
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          data: (data) => Scaffold(
            appBar: Bitflow.getAppBar(
              '사용자 등록 요청',
              true,
              1,
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 32,
                    ),
                    child: TopNavbarRequest(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 96,
                    ),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: _getRegIndex(
                          index,
                          data,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.5,
                          child: BottomSubmitBtn(
                            onPressed: index < 0
                                ? null
                                : () {
                                    if (_tryValidation()) {
                                      ref
                                          .read(regIndexProvider.notifier)
                                          .state--;
                                    }
                                  },
                            text: '이전',
                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: BottomSubmitBtn(
                            onPressed: _tryAuthValidation(
                              index,
                              data,
                            )
                                ? null
                                : () {
                                    if (_tryValidation()) {
                                      ref
                                          .read(regIndexProvider.notifier)
                                          .state++;
                                    }
                                  },
                            text: index == 1 ? '등록요청' : '다음',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  Widget _getRegIndex(double index, UserRegModel model) {
    if (index == 1) {
      return BelongAgency(
        titles: const [
          '담당지역',
          '소속기관',
          '소속 증명 정보',
          '담당 환자 유형',
        ],
        patientTypes: const [
          '투석',
          '임산부',
          '신생아',
          '응급',
        ],
      );
    }
    if (index == 0) {
      return JobRole(
        title: const [
          '소속기관 유형',
          '권한그룹 선택',
          '세부 권한 선택',
        ],
        affiliationType: const [
          '보건소',
          '병상배정반',
          '의료진',
          '구급대',
          '전산담당',
        ],
        authGroupSelectedImages: const [
          'assets/auth_group/selected_request.png',
          'assets/auth_group/selected_approve.png',
          'assets/auth_group/selected_assign.png',
          'assets/auth_group/selected_system_admin.png',
        ],
        authGroupDisabledImages: const [
          'assets/auth_group/disabled_request.png',
          'assets/auth_group/disabled_approve.png',
          'assets/auth_group/disabled_assign.png',
          'assets/auth_group/disabled_system_admin.png',
        ],
        authGroupTitles: const [
          '병상요청그룹',
          '병상승인그룹',
          '병상배정그룹',
          '시스템 관리자',
        ],
        authGroupSubTitles: const [
          '보건소, 병상배정반, 의료진',
          '병상배정반',
          '의료진',
          '전산운영',
        ],
        detailAuthTitles: const [
          '일반',
          '게스트',
        ],
        detailAuthSubTitles: const [
          '일반업무처리 및 사용자 초대 권한',
          '업무 조회만 가능',
        ],
        model: model,
      );
    }
    if (index == -1) {
      return SelfAuth(
        model: model,
      );
    }
    return const Placeholder();
  }

  bool _tryValidation() {
    bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  bool _tryAuthValidation(double index, UserRegModel model) {
    if (index == 0) {
      return model.attcId == null ||
          model.jobCd == null ||
          model.ocpCd == null ||
          model.attcId!.isEmpty ||
          model.jobCd!.isEmpty ||
          model.ocpCd!.isEmpty;
    }
    return index > 1;
  }

  final formKey = GlobalKey<FormState>();
}
