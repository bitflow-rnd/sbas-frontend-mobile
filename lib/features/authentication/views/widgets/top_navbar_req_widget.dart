import 'package:flutter/material.dart';
import 'package:sbas/features/authentication/views/widgets/top_nav_req_item_widget.dart';

class TopNavbarRequest extends StatefulWidget {
  const TopNavbarRequest({super.key});

  @override
  State<TopNavbarRequest> createState() => TopNavbarRequestState();
}

class TopNavbarRequestState extends State<TopNavbarRequest> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width - 64;

    return Stack(
      children: [
        AnimatedAlign(
          heightFactor: 14,
          alignment: const Alignment(
            0,
            0,
          ),
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Container(
            width: width,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Colors.lightBlue,
            ),
          ),
        ),
        const TopNavRequestItem(
          x: -1,
          index: 1,
          text: '본인인증',
        ),
        const TopNavRequestItem(
          x: 0,
          index: 2,
          text: '업무역할',
        ),
        const TopNavRequestItem(
          x: 1,
          index: 3,
          text: '소속기관',
        ),
      ],
    );
  }

  late double width;
}
