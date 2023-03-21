import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/assign/views/widgets/top_navbar_widget.dart';

class TopNavItem extends StatefulWidget {
  const TopNavItem({
    super.key,
    required this.text,
    required this.x,
  });
  final String text;
  final double x;

  @override
  State<TopNavItem> createState() => _TopNavItemState();
}

class _TopNavItemState extends State<TopNavItem> {
  @override
  Widget build(BuildContext context) {
    final tn = context.findAncestorStateOfType<TopNavbarState>()!;

    return Align(
      alignment: Alignment(
        widget.x,
        0,
      ),
      child: InkWell(
        onTap: () {
          tn.setState(
            () => tn.x = widget.x,
          );
          setState(
            () => color = tn.x == widget.x ? Colors.black : Colors.grey,
          );
        },
        child: Container(
          width: tn.width * 0.2,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: widget.text,
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
              children: const [
                WidgetSpan(
                  child: Gaps.h1,
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    maxRadius: 8,
                    child: Text(
                      '7',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
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
  }

  Color color = Colors.grey;
}
