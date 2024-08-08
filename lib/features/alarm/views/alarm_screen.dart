import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/alarm/provider/alarm_provider.dart';
import 'package:sbas/features/alarm/views/widgets/alarm_item_card_widget.dart';

class AlarmPage extends ConsumerWidget {
  const AlarmPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> dropdownList = ['최근1개월', '최근3개월', '최근1년'];
    String selectedDropdown = '최근1개월';
    final alarms = ref.watch(alarmsProvider);

    return Scaffold(
      backgroundColor: Palette.dividerGrey,
      appBar: SBASAppBar(
        title: '알림함',
        actions: [
          Container(
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
                // setState(() {
                //   selectedDropdown = value;
                // });
              },
            ),
          ),
        ],
      ),
      body: GestureDetector(
        // onTap: () => ref.invalidate(),
        child: alarms.when(
              loading: () => const SBASProgressIndicator(),
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(
                    color: Palette.mainColor,
                  ),
                ),
              ),
              data: (list) => SingleChildScrollView(
                      child: IntrinsicHeight(
                        child: Stack(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Column(children: [
                              Expanded(
                                child: CustomPaint(
                                    painter: DashedLineVerticalPainter(),
                                    size: const Size(1, double.infinity)),
                              ),
                            ]),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dateFragment(
                                  "${list.items[0].rgstDttm}월"),
                              for (var alarmItem in list.items)
                                AlarmItemCard(
                                  title: alarmItem.title,
                                  body: alarmItem.detail,
                                  dateTime: alarmItem.rgstDttm,
                                ),
                            ],
                          ),
                        ]),
                      ),
                    ),
            ),
      ),
    );
  }

  Widget _emptyPage() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/home/warn_icon.png',
                width: 100.w,
                // height: 200.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                '수신된 알림이 없습니다.',
                style: CTS.medium(
                  fontSize: 15,
                  color: Palette.greyText,
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dateFragment(String date) {
    return Container(
      padding: EdgeInsets.only(top: 18.h),
      margin: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 9.w, right: 8.w),
            height: 10.w,
            width: 10.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: Palette.greyText,
                width: 1.r,
              ),
            ),
          ),
          Image.asset(
            "assets/common_icon/calender_icon.png",
            height: 16.h,
            width: 16.w,
          ),
          SizedBox(width: 4.w),
          Text(
            date,
            style: CTS.medium(fontSize: 13, color: Palette.black),
          ),
        ],
      ),
    );
  }

}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Palette.greyText.withOpacity(0.4)
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
