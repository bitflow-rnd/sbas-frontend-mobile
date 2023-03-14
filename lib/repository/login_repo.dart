import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginRepo {
  final _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;

  bool get isFirebaseAuth => false;

  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> emailSignUp(
    String email,
    String password,
  ) async =>
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  emailSignIn(
    String email,
    String password,
  ) async =>
      _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
}

final authRepo = Provider((ref) => LoginRepo());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);

  return repo.authStateChanges();
});
