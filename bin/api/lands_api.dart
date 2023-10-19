import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models.dart/lands_model.dart';
import '../services/lands_service.dart';
import 'api.dart';

class LandsApi extends Api {
  final LandsService _service;

  LandsApi(this._service);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/lands', (Request req) async {
      List<LandsModel> lands = await _service.findAll();
      List<Map> landsMap = lands.map((land) => land.toMap()).toList();
      return Response.ok(jsonEncode(landsMap),
          headers: {'content-type': 'application/json'});
    });

    router.post('/lands', (Request req) async {
      var body = await req.readAsString();
      _service.save(LandsModel.fromJson(body));
      return Response(201);
    });

    router.put('/lands', (Request req) {
      // String? id = req.url.queryParameters['id'];
      // _service.save();
      return Response(201);
    });

    router.delete('/lands', (Request req) {
      _service.delete(0);
      // String? id = req.url.queryParameters['id'];
      return Response.ok('Deletar');
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
