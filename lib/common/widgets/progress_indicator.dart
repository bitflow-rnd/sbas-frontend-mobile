import 'package:flutter/material.dart';

class SBASProgressIndicator extends StatelessWidget {
  const SBASProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation(
          Colors.lightBlueAccent,
        ),
      ),
    );
  }
}
