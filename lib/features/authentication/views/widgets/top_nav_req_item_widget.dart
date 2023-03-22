import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/views/widgets/top_navbar_req_widget.dart';

class TopNavRequestItem extends StatefulWidget {
  const TopNavRequestItem({
    super.key,
    required this.x,
    required this.index,
    required this.text,
  });
  final double x;
  final int index;
  final String text;

  @override
  State<TopNavRequestItem> createState() => _TopNavRequestItemState();
}

class _TopNavRequestItemState extends State<TopNavRequestItem> {
  @override
  Widget build(BuildContext context) {
    final tn = context.findAncestorStateOfType<TopNavbarRequestState>()!;

    return Align(
      alignment: Alignment(widget.x, 0),
      child: SizedBox(
        width: tn.width * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(
                4,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
              ),
              child: Text(
                widget.index.toString(),
              ),
            ),
            Gaps.h2,
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
