import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/views/widgets/top_navbar_widget.dart';

class TopNavItem extends StatefulWidget {
  const TopNavItem({super.key, required this.text, required this.x});
  final String text;
  final double x;
  // final double width;
  @override
  State<TopNavItem> createState() => _TopNavItemState();
}

class _TopNavItemState extends State<TopNavItem> {
  @override
  Widget build(BuildContext context) {
    final tn = context.findAncestorStateOfType<TopNavbarState>()!;
    bool isSelected() => tn.x == widget.x;
    return Align(
      alignment: Alignment(
        widget.x,
        0,
      ),
      child: InkWell(
        onTap: () => tn.setState(
          () => tn.x = widget.x,
        ),
        child: Container(
          width: tn.width * 0.2,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: CTS.medium(
                  color: color,
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 2.w),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected() ? Palette.mainColor : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected() ? Palette.mainColor : Palette.greyText_60,
                      width: 1.2.r,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(2.3.r),
                    child: Center(
                      child: Text(
                        '1',
                        style: CTS.medium(
                          color: isSelected() ? Colors.white : Palette.greyText,
                          fontSize: 10.0,
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
    );
  }

  Color color = Colors.grey;
}
