import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models.dart/culture_model.dart';
import '../services/service_interface.dart';
import 'api.dart';

class CulturesApi extends Api {
  final ServiceInterface<CultureModel> _cultureService;

  CulturesApi(this._cultureService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/cultures', (Request req, String landId, String userId) async {
      List<CultureModel> cultures = await _cultureService.findAll();
      List<Map> culturesMap = cultures.map((order) => order.toMap()).toList();

      return Response.ok(jsonEncode(culturesMap),
          headers: {'content-type': 'application/json'});
    });

    router.post('/cultures', (Request req) async {
      var body = await req.readAsString();
      _cultureService.save(CultureModel.fromJson(body));
      return Response(201);
    });

    router.put('/cultures/<cultureId>', (Request req, String landId, String userId, String cultureId) async {
      var body = await req.readAsString();
      var result = await _cultureService.save(CultureModel.fromJson(body));
      return Response.ok(result);
    });

    router.delete('/cultures/<cultureId>', (Request req, String landId, String userId, String cultureId) async {
      await _cultureService.delete(int.parse(cultureId));
      return Response.ok('Ordem deletada');
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
