import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/messages/models/user_contact_model.dart';

class ContactItem extends StatelessWidget{

  final UserContact userContact;

  const ContactItem({super.key, required this.userContact});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Image.asset(
            "assets/message/doctor_icon.png",
            height: 36.h,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userContact.userNm ?? "",
                style: CTS.medium(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
              Gaps.v8,
              Text(
                "${userContact.instNm ?? ""} / ${userContact.ocpCd ?? ""}",
                style: CTS(
                  color: Palette.greyText_80,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }}