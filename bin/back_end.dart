import 'package:shelf/shelf.dart';
import 'api/login_api.dart';
import 'api/user_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injectors.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';
import 'package:password_dart/password_dart.dart';

void main() async {
  // CustomEnv.fromFile('.env');

  final di = await Injectors().initialize();

  var passResult = Password.hash('senha123', PBKDF2());
  print(passResult);
  var passVerify = Password.verify('senha123', passResult);
  print(passVerify);

  final CustomServer customServer = CustomServer();

  var cascadeHandler = Cascade()
      .add(
        di.get<LoginApi>().getHandler(),
      )
      .add(
        di.get<LoginApi>().getHandler(isSecurity: true),
      )
      .add(di.get<UserApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(logRequests())
      .addHandler(cascadeHandler);

  customServer.initialize(
      address: await CustomEnv().get<String>(key: 'server_address'),
      port: await CustomEnv().get<int>(key: 'server_port'),
      handler: handler);
}
