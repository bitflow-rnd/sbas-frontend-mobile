
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectMessageScreen extends ConsumerWidget {
  const DirectMessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.amber,
    );
  }

  static String routeName = 'directMessage';
  static String routeUrl = '/directMessage';
}
