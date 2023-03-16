import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/models/auth_token_model.dart';
import 'package:sbas/models/jwt_model.dart';
import 'package:sbas/models/user_model.dart';
import 'package:sbas/provider/login_provider.dart';
import 'package:sbas/util.dart';

class LoginRepo {
  final _firebaseAuth = FirebaseAuth.instance;
  final _auth = LoginProvider();

  Future<bool> get isLoggedIn async {
    final authToken = prefs.getString('auth_token');

    if (authToken != null && authToken.isNotEmpty) {
      final map = await _auth.getUser(authToken);

      if (map != null) {
        final jwt = JwtModel.fromJson(map);
        final name = jwt.token?.name ?? '';

        if (kDebugMode) {
          print(jwt.toJson());
        }
        if (name.isNotEmpty) {
          return await prefs.setString('id', name);
        }
      }
    }
    return false;
  }

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

  Future<AuthTokenModel?> signIn(UserModel user) async {
    final map = await _auth.postSignIn(
      user.toJson(),
    );
    if (map != null) {
      final ctor = AuthTokenModel.fromJson(map);

      if (ctor.token != null && ctor.token!.isNotEmpty) {
        prefs.setString('auth_token', ctor.token!);
      }
      return ctor;
    }
    return null;
  }
}

final authRepo = Provider((ref) => LoginRepo());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);

  return repo.authStateChanges();
});
