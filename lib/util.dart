import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showFirebaseErrorSnack(
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

late SharedPreferences prefs;
