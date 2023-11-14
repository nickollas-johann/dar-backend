import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models.dart/lands_model.dart';
import '../services/service_interface.dart';
import 'api.dart';

class LandsApi extends Api {
  final ServiceInterface<LandsModel> _service;

  LandsApi(this._service);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/lands', (Request req, String userId) async {
      List<LandsModel> lands = await _service.findAll();
      List<Map> landsMap = lands.map((land) => land.toMap()).toList();
      return Response.ok(jsonEncode(landsMap),
          headers: {'content-type': 'application/json'}
          );
    });

    router.get('/lands', (Request req, String userId) async {
      var user = await _service.findOne(int.parse(userId));
      return Response.ok(jsonEncode(user));
    });

    router.post('/lands', (Request req, String userId) async {
      var body = await req.readAsString();
      _service.save(LandsModel.fromJson(body));
      return Response(201);
    });

    router.put('/lands', (Request req, String userId) async {
      var body = await req.readAsString();
      var result = await _service.save(LandsModel.fromJson(body));
      return Response.ok(result);
    });

    router.delete('/lands', (Request req, String userId) async {
      await _service.delete(int.parse(userId));
      return Response.ok('Deletou a terra');
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
