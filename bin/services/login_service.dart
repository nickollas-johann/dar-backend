import 'dart:developer';
import 'package:password_dart/password_dart.dart';
import '../to/auth_to.dart';
import 'user_service.dart';

class LoginService {
  final UserService _userService;

  LoginService(this._userService);

  Future<int> authenticate(AuthTo authTo) async {
    try {
      var user = await _userService.findByEmail(authTo.userEmail);
      if (user == null) {
        return -2;
      } else {
        return Password.verify(authTo.password, user.userPassword!)
            ? user.userId!
            : -3;
      }
    } catch (e) {
      log('[ERROR] -> Authenticate method by email ${authTo.userEmail}');
      return -4;
    }
  }
}
