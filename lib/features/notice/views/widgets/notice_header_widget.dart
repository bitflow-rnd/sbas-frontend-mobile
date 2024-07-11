import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class NoticeHeader extends ConsumerWidget {
  const NoticeHeader({
    super.key,
    required this.selectedDropdown,
    required this.dropdownList,
    required this.onDropdownChanged,
  });

  final List<String> dropdownList;
  final String selectedDropdown;
  final ValueChanged<String?> onDropdownChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(right: 16.w, top: 3.h, bottom: 3.h),
      height: 40.h,
      width: 100.w,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(4.r),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 4.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.greyText_30, width: 1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.greyText_30, width: 1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.greyText_30, width: 1),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        value: selectedDropdown,
        items: dropdownList.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: CTS(fontSize: 11, color: Palette.black),
            ),
          );
        }).toList(),
        onChanged: (dynamic value) {
          onDropdownChanged(value);
        },
      ),
    );
  }
}
