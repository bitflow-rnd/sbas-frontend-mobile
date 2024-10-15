import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/patient_register_bloc.dart';
import 'package:sbas/features/lookup/models/patient_duplicate_check_model.dart';
import 'package:sbas/features/lookup/models/patient_reg_info_model.dart';

class PatientInfoModal {
  approveReqestModal(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "승인 하시겠습니까?",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          button1Function: () {
            Navigator.pop(context);
          },
          imageHeight: 44.h,
        ));
  }

  approvedCompleteModal(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "승인 처리 되었습니다.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          imageHeight: 44.h,
        ));
  }

  denyReqestModal(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "반려 하시겠습니까?",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          button1Function: () {
            Navigator.pop(context);
          },
          imageHeight: 44.h,
        ));
  }

  deniedCompleteModal(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "반려 처리 되었습니다.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          imageHeight: 44.h,
        ));
  }
}
