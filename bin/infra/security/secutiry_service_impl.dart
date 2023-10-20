import 'package:shelf/shelf.dart';
import '../../utils/custom_env.dart';
import 'security_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityServiceImpl implements SecurityService<JWT> {
  @override
  Future<String> genetateJWT(String userId) async {
    var jwt = JWT({
      'iat': DateTime.now().microsecondsSinceEpoch,
      'sub': userId,
      'userId': userId,
      'roles': ['admin', 'farmer', 'professional']
    });
    String key = await CustomEnv().get(key: 'jwt_key');

    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv().get(key: 'jwt_key');

    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidException {
      return null;
    } on JWTNotActiveException {
      return null;
    } on JWTExpiredException {
      return null;
    } on JWTUndefinedException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers['Authorization'];

        JWT? jwt;

        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        var request = req.change(context: {'jwt': jwt});

        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJwt => createMiddleware(
        requestHandler: (Request req) {
          if (req.context['jwt'] == null) {
            return Response.forbidden('Not Authorized');
          }
          return null;
        },
      );
}
