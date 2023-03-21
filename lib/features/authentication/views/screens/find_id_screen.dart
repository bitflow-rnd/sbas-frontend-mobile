import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/features/authentication/views/screens/authenticate_phone_screen.dart';
import 'package:sbas/features/authentication/views/widgets/find_id_result_widget.dart';
import 'package:sbas/features/authentication/views/widgets/find_id_widget.dart';

class FindIdScreen extends ConsumerStatefulWidget {
  const FindIdScreen({super.key});

  @override
  ConsumerState<FindIdScreen> createState() => FindIdScreenState();
}

class FindIdScreenState extends ConsumerState<FindIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '아이디 찾기',
        id.isEmpty,
        0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 36,
        ),
        child: id.isNotEmpty
            ? FindIdResult(
                id: id,
              )
            : const FindId(),
      ),
    );
  }

  Future authenticate() async {
    final result = await Navigator.push<String?>(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPhone(),
      ),
    );
    if (kDebugMode) {
      print(result);
    }
    if (result != null && result.isNotEmpty) {
      setState(() => id = result);
    }
  }

  String id = '';
}
