import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import '../models.dart/user_model.dart';
import '../services/user_service.dart';
import 'api.dart';

class UserApi extends Api {
  final UserService _userService;

  UserApi(this._userService);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.get('/user/<userId>', (Request req, String userId) async {
      var user = await _userService.findOne(int.parse(userId));
      return Response.ok(user.toString());
    });

    router.post('/user', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) {
        return Response(400);
      }
      var result = await _userService.save(
        UserModel.fromRequest(
          jsonDecode(body),
        ),
      );
      if (result) {
        return Response(201);
      } else {
        return Response(500);
      }
    });
    return createHandler(router: router, isSecurity: isSecurity);
  }
}
