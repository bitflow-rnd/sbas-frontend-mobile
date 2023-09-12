import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/api/v1_provider.dart';
import 'package:sbas/features/authentication/models/auth_token_model.dart';
import 'package:sbas/features/authentication/models/jwt_model.dart';
import 'package:sbas/features/authentication/models/user_model.dart';
import 'package:sbas/features/authentication/models/user_reg_req_model.dart';
import 'package:sbas/features/authentication/providers/login_provider.dart';
import 'package:sbas/features/messages/providers/talk_rooms_provider.dart';
import 'package:sbas/util.dart';

class LoginRepo {
  final _auth = LoginProvider();

  Future<bool> get isLoggedIn async {
    final token = prefs.getString('auth_token');

    if (token != null && token.isNotEmpty) {
      final map = await _auth.getUser(token);

      if (map != null) {
        final jwt = JwtModel.fromJson(map);
        final name = jwt.token?.name ?? '';
        final userNm = jwt.token?.subject ?? '';

        if (jwt.token != null) {
          userToken = jwt.token!;
        }
        if (name.isNotEmpty) {
          // TalkRoomsProvider().connect(name);

          await prefs.setString('userNm', userNm);
          return await prefs.setString('id', name);
        }
      }
    }
    return false;
  }

  bool get isFirebaseAuth => false;

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

  Future<AuthTokenModel?> getUser(UserModel user) async {
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

  Future<UserDetailModel?> getUserDetail(String id) async {
    final map = await V1Provider().getAsync(
      "/private/user/user/$id",
    );
    if (map != null) {
      return UserDetailModel.fromJson(map);
    }
    return null;
  }

  Future<bool> logout() async {
    userToken = Token.empty();
    // ref..close();
    await prefs.remove('auth_token');
    await prefs.clear();
    return true;
  }
}

Token userToken = Token.empty();
final authRepo = Provider((ref) => LoginRepo());
