import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';

class SBASAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final double elevation;

  const SBASAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        title,
        style: CTS.medium(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      actions: actions,
      elevation: elevation,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: const BackButton(
        color: Colors.black,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
