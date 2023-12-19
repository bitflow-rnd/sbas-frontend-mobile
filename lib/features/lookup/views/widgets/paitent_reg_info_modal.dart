import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/common.dart';
import 'package:sbas/constants/extensions.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class PatientRegInfoModal {
  epidUploadConfirmModal(context) {
    Common.showModal(
      context,
      Common.commonModal(
        context: context,
        mainText: "역학조사서 파일을 기반으로\n환자정보를 자동입력 하였습니다.\n내용을 확인해주세요.",
        imageWidget: Image.asset(
          "assets/auth_group/modal_check.png",
          width: 44.h,
        ),
        imageHeight: 44.h,
      )
    );
  }

  showModal3(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "등록된 환자의 이름, 주민등록번호가\n역학조사서의 내용과 다릅니다.\n내용을 확인해주세요.",
          imageWidget: Image.asset(
            "assets/auth_group/modal_check.png",
            width: 44.h,
          ),
          imageHeight: 44.h,
        ));
  }

  showModal4(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "소속 기관의 승인자에게\n승인 요청을 보냅니다.",
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

  showModal5(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "소속 기관의 승인자가 없습니다.\n시스템관리자에게\n승인요청을 보냅니다.",
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

  showModal6(context) {
    Common.showModal(
        context,
        Common.commonModal(
          context: context,
          mainText: "승인된 사용자입니다.\n지금부터 로그인 가능합니다.",
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
}
