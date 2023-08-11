import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/bottom_submit_btn_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/authentication/blocs/job_role_bloc.dart';
import 'package:sbas/features/authentication/blocs/user_reg_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/belong_agency_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/job_role_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/self_auth_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/top_navbar_req_widget.dart';

class UserRegisterRequestScreenV2 extends ConsumerStatefulWidget {
  const UserRegisterRequestScreenV2({
    super.key,
  });

  @override
  ConsumerState<UserRegisterRequestScreenV2> createState() => UserRegisterRequestScreenV2State();
}

class UserRegisterRequestScreenV2State extends ConsumerState<UserRegisterRequestScreenV2> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final index = ref.watch(regIndexProvider);
    final signUp = ref.watch(signUpProvider);

    return Scaffold(
      appBar: Bitflow.getAppBar(
        '사용자 등록 요청',
        true,
        1,
      ),
      body: ModalProgressHUD(
        inAsyncCall: signUp.isLoading,
        progressIndicator: const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(
              Palette.mainColor,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32.h,
                  horizontal: 24.w,
                ),
                child: const TopNavbarRequest(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 96.h,
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: _getRegIndex(
                      index,
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
                                  ref.read(regIndexProvider.notifier).state--;
                                }
                              },
                        text: '이전',
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: BottomSubmitBtn(
                        onPressed: () {
                          if (_tryValidation()) {
                            final index = ref.read(regIndexProvider.notifier);

                            if (index.state < 1) {
                              index.state++;
                            } else {
                              ref.read(signUpProvider.notifier).signUp(context);
                            }
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

  Widget _getRegIndex(double index) {
    if (index == 1) {
      return const BelongAgency(
        titles: [
          '담당/근무지역',
          '소속기관',
          '담당 환자 유형',
          '직급',
          '소속 증명 정보',
        ],
      );
    }
    if (index == 0) {
      return const JobRole(
        title: [
          '소속기관 유형',
          '권한그룹 선택',
          '세부 권한 선택',
        ],
        authGroupSelectedImages: [
          'assets/auth_group/selected_request.png',
          'assets/auth_group/selected_approve.png',
          'assets/auth_group/selected_assign.png',
          'assets/auth_group/selected_system_admin.png',
        ],
        authGroupDisabledImages: [
          'assets/auth_group/disabled_request.png',
          'assets/auth_group/disabled_approve.png',
          'assets/auth_group/disabled_assign.png',
          'assets/auth_group/disabled_system_admin.png',
        ],
        authGroupTitles: [
          '병상요청그룹',
          '병상승인그룹',
          '병상배정그룹',
          '시스템 관리자',
        ],
        authGroupSubTitles: [
          '보건소, 병상배정반, 의료진',
          '병상배정반',
          '의료진',
          '전산운영',
        ],
        detailAuthTitles: [
          '일반',
          '게스트',
        ],
        detailAuthSubTitles: [
          '일반업무처리 및 사용자 초대 권한',
          '업무 조회만 가능',
        ],
      );
    }
    if (index == -1) {
      return const SelfAuth();
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

  final formKey = GlobalKey<FormState>();
}
