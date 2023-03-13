import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginRepo {
  bool get isLoggedIn => false;
  authStateChanges() {}
}

final authRepo = Provider((ref) => LoginRepo());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);

  return repo.authStateChanges();
});
