import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/common/widgets/app_bar_widget.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/alarm/model/alarm_item_model.dart';
import 'package:sbas/features/alarm/provider/alarm_provider.dart';
import 'package:sbas/features/alarm/views/widgets/alarm_item_card_widget.dart';

class AlarmPage extends ConsumerStatefulWidget {
  const AlarmPage({super.key});

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends ConsumerState<AlarmPage> {
  List<String> dropdownList = ['최근1개월', '최근3개월', '최근1년'];
  String selectedDropdown = '최근1개월';
  bool _isReadAlarmsCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 페이지가 다시 보여질 때마다 데이터를 새로 고침
    ref.invalidate(alarmsProvider);
  }

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  selectedDropdown = value;
                });
                // 드롭다운 값이 변경될 때마다 데이터 새로고침
                ref.invalidate(alarmsProvider);
              },
            ),
          ),
        ],
      ),
      body: GestureDetector(
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
          data: (list) {
            // 알림 데이터를 불러온 후 읽음 처리가 한 번만 호출되도록 합니다.
            if (!_isReadAlarmsCalled) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(alarmProvider).readAlarms();
                _isReadAlarmsCalled = true;
              });
            }

            final groupedAlarms = groupAlarmsByData(list.items);

            return SingleChildScrollView(
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomPaint(
                              painter: DashedLineVerticalPainter(),
                              size: const Size(1, double.infinity),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var date in groupedAlarms.keys)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dateFragment(date), // 날짜 헤더
                              for (var alarmItem in groupedAlarms[date]!)
                                alarmItemCard(
                                  item: alarmItem,
                                ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Map<String, List<AlarmItemModel>> groupAlarmsByData(
      List<AlarmItemModel> alarms) {
    Map<String, List<AlarmItemModel>> groupedAlarms = {};

    for (var alarm in alarms) {
      if (groupedAlarms.containsKey(alarm.date)) {
        groupedAlarms[alarm.date]!.add(alarm);
      } else {
        groupedAlarms[alarm.date] = [alarm];
      }
    }

    return groupedAlarms;
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
