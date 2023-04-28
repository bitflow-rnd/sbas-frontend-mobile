import 'package:flutter/material.dart';
import 'package:sbas/constants/palette.dart';

class SBASProgressIndicator extends StatelessWidget {
  const SBASProgressIndicator({
    super.key,
  });
  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation(
            Palette.mainColor,
          ),
        ),
      );
}
