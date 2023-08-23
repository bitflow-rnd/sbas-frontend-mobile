import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';

class TopNavItem extends ConsumerWidget {
  const TopNavItem({
    required this.count,
    super.key,
    required this.width,
    required this.text,
    required this.x,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) => Align(
        alignment: Alignment(
          x,
          0,
        ),
        child: InkWell(
          onTap: () => ref.read(assignBedProvider.notifier).setTopNavItem(x),
          child: IntrinsicWidth(
            child: Container(
              height: 20.h,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: CTS.medium(
                      color: Colors.grey,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  if (count != 0)
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Palette.mainColor : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Palette.mainColor : Palette.greyText_60,
                            width: 1.2.r,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(2.3.r),
                          child: Center(
                            child: Text(
                              '$count',
                              style: CTS.medium(
                                color: isSelected ? Colors.white : Palette.greyText,
                                fontSize: 10.0.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
  final String text;
  final double x, width;
  final int count;
  final bool isSelected;
}
