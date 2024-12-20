import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';

class DetailAuthorization<T> extends ConsumerWidget {
  const DetailAuthorization({
    super.key,
    required this.title,
    required this.subTitle,
    required this.index,
    required this.selectedIndex,
    required this.onChanged,
  });
  final String title, subTitle;
  final T index, selectedIndex;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
        borderRadius: BorderRadius.circular(
          24,
        ),
        onTap: () => onChanged(index),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: index == selectedIndex ? Colors.transparent : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(
                  30,
                ),
                color: index == selectedIndex ? Palette.mainColor : Colors.transparent,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 8.h,
              ),
              child: Text(
                title.length == 2 ? '$title   ' : title,
                style: CTS(
                  color: index == selectedIndex ? Colors.white : Colors.grey,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Gaps.h12,
            Text(
              subTitle,
              style: CTS(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
}
