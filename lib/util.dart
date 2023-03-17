import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbas/screens/find_id_screen.dart';
import 'package:sbas/screens/set_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showErrorSnack(
  BuildContext context,
  Object? error,
) {
  String message = '';

  switch (error) {
    case FirebaseException:
      message = (error as FirebaseException).message ?? '';
      break;

    default:
      if (kDebugMode) {
        print(error);
      }
      break;
  }
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1750,
        ),
        content: Text(
          message,
        ),
      ),
    );
  }
}

void findId(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FindIdScreen(),
      ),
    );
Future setPassword(BuildContext context) async => await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SetPasswordScreen(),
    ));

String format(int remainingTime) =>
    Duration(seconds: remainingTime).toString().substring(2, 7);

late SharedPreferences prefs;
