import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/blocs/job_role_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/top_nav_req_item_widget.dart';

class TopNavbarRequest extends ConsumerWidget {
  const TopNavbarRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width - 32;
    final x = ref.watch(regIndexProvider);

    return Stack(
      children: [
        Align(
          heightFactor: 14,
          child: Container(
            width: width,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: Colors.grey.shade300,
            ),
          ),
        ),
        AnimatedAlign(
          heightFactor: 14,
          alignment: Alignment(
            x,
            0,
          ),
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Container(
            width: width * 0.3,
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
}
