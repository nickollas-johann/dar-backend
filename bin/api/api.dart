import 'package:shelf/shelf.dart';
import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler router,
    bool isSecurity = false,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];

    if (isSecurity) {
      var securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        securityService.authorization,
        securityService.verifyJwt,
      ]);
    }

    var pipeline = Pipeline();
    middlewares.forEach((m) => pipeline = pipeline.addMiddleware(m));

    return pipeline.addHandler(router);
  }
}
