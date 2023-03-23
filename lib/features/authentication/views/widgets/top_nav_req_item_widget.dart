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
      heightFactor: 1,
      alignment: Alignment(widget.x, 0),
      child: SizedBox(
        width: tn.width * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(
                5,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tn.x == widget.x ? Colors.blue : Colors.grey,
              ),
              child: Text(
                widget.index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Gaps.h2,
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 16,
                color: tn.x == widget.x ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
