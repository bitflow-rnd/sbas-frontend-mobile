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
import 'package:sbas/features/lookup/views/widgets/user_reg_top_nav_widget.dart';
import 'package:sbas/util.dart';

import '../../../constants/common.dart';

class UserRegisterRequestScreenV2 extends ConsumerStatefulWidget {
  const UserRegisterRequestScreenV2({
    super.key,
  });

  @override
  ConsumerState<UserRegisterRequestScreenV2> createState() =>
      UserRegisterRequestScreenV2State();
}

final isPhoneAuthSuccess = StateProvider.autoDispose<bool>((ref) => false);

class UserRegisterRequestScreenV2State
    extends ConsumerState<UserRegisterRequestScreenV2> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final index = ref.watch(regIndexProvider);
    final signUp = ref.watch(signUpProvider);
    final navbarItems = [
      '사용자 정보',
      '업무역할',
      '소속기관',
    ];

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
                  vertical: 25.h,
                  horizontal: 24.w,
                ),
                child: UserRegTopNav(
                  x: index.toDouble(),
                  items: navbarItems,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 80.h,
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
                        onPressed: index == -1
                            ? () {
                                Navigator.pop(context);
                              }
                            : () {
                                ref.read(regIndexProvider.notifier).state--;
                              },
                        text: '이전',
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: BottomSubmitBtn(
                        onPressed: () {
                          if (_tryValidation(ref, index)) {
                            final index = ref.read(regIndexProvider.notifier);

                            if (index.state < 1) {
                              // TODO showToast 말고 다른걸로
                              final user = ref.read(regUserProvider);
                              ref
                                  .watch(signUpProvider.notifier)
                                  .existId(user.id)
                                  .then((value) {
                                if (value) {
                                  showToast("사용중인 아이디입니다.");
                                  return;
                                } else {
                                  index.state++;
                                }
                              });
                            } else {
                              if (validateSumbit(ref)) {
                                ref
                                    .read(signUpProvider.notifier)
                                    .signUp(context);
                                Common.showModal(
                                  context,
                                  Common.commonModal(
                                    context: context,
                                    mainText:
                                        "사용자 등록 요청이 완료되었습니다.\n관리자 승인후 로그인이 가능합니다.",
                                    imageWidget: Image.asset(
                                      "assets/auth_group/modal_check.png",
                                      width: 44.h,
                                    ),
                                    imageHeight: 44.h,
                                    button2Function: () {
                                      Navigator.pop(context, true);
                                      Navigator.pop(context, true);
                                      ref
                                          .read(regIndexProvider.notifier)
                                          .state = -1;
                                    },
                                  ),
                                );
                              }
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

  validateSumbit(WidgetRef ref) {
    final user = ref.read(regUserProvider);
    debugPrint(user.toJson().toString());
    if (user.id == '' || user.id == null) {
      return false;
    }
    if (user.pw == '' || user.pw == null) {
      return false;
    }
    if (user.userNm == '' || user.userNm == null) {
      return false;
    }
    if (user.telno == '' || user.telno == null) {
      return false;
    }
    if (user.jobCd == '' || user.jobCd == null) {
      return false;
    }
    if (user.instTypeCd == '' || user.instTypeCd == null) {
      return false;
    }
    if (user.instId == '' || user.instId == null) {
      return false;
    }
    if (user.instNm == '' || user.instNm == null) {
      return false;
    }
    if (user.dutyDstr1Cd == '' || user.dutyDstr1Cd == null) {
      return false;
    }
    if (user.btDt == '' || user.btDt == null) {
      return false;
    }
    // if (user.authCd == '' || user.authCd == null) {
    //   return false;
    // }
    return true;
  }

  Widget _getRegIndex(int index) {
    if (index == -1) {
      return const SelfAuth();
    } else if (index == 0) {
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
          '보건소',
          '병상배정반',
          '의료진',
          '시스템 관리자',
        ],
        authGroupSubTitles: [
          '병상요청',
          '병상요청, 병상승인, 이송처리',
          '병상요청, 병상배정',
          '모니터링, 테스트',
        ],
        detailAuthTitles: [
          '일반',
          // '게스트',
        ],
        detailAuthSubTitles: [
          '일반업무처리 및 사용자 초대 권한',
          // '업무 조회만 가능',
        ],
      );
    } else if (index == 1) {
      return const BelongAgency(
        titles: [
          '담당지역',
          '소속기관',
          '담당 환자 유형(다중선택)',
          '직급',
          '소속 증명 정보',
        ],
      );
    }

    return const Placeholder();
  }

  bool _tryValidation(WidgetRef ref, int index) {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  final formKey = GlobalKey<FormState>();
}
