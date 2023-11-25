import 'package:shelf/shelf.dart';
import 'api/culture_api.dart';
import 'api/lands_api.dart';
import 'api/login_api.dart';
import 'api/orders_api.dart';
import 'api/user_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injectors.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  // CustomEnv.fromFile('.env');

  final di = await Injectors().initialize();

  final CustomServer customServer = CustomServer();

  var cascadeHandler = Cascade()
      .add(
        di.get<LoginApi>().getHandler(),
      )
      .add(
        di.get<UserApi>().getHandler(isSecurity: true),
      )
      .add(
        di.get<LandsApi>().getHandler(isSecurity: true),
      )
      .add(
        di.get<OrdersApi>().getHandler(isSecurity: true),
      )
      .add(
        di.get<CulturesApi>().getHandler(isSecurity: true),
      )
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception.contentTypeJson).addMiddleware(MiddlewareInterception.cors)
      .addHandler(cascadeHandler);

  customServer.initialize(
      address: await CustomEnv().get<String>(key: 'server_address'),
      port: await CustomEnv().get<int>(key: 'server_port'),
      handler: handler);
}
