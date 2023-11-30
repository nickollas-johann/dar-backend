import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  static Middleware get contentTypeJson {
    return createMiddleware(
      responseHandler: (Response res) {
        return res.change(headers: {'content-type': 'application/json'});
      },
    );
  }

  static Middleware get cors {
    final headersPermited = {'Access-Control-Allow-Origin': '*'};

    Response? handlerOptions(Request req) {
      if (req.method == 'OPTIONS') {
        return Response(200, headers: headersPermited);
      } else {
        return null;
      }
    }

    Response addCorsHeader(Response res) =>
        res.change(headers: headersPermited);

    return createMiddleware(
        requestHandler: handlerOptions, responseHandler: addCorsHeader);
  }
}
