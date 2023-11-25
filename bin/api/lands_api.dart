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

    router.get('/<userId>/lands', (Request req, String userId) async {
      try {
        List<LandsModel> lands = await _service.findAll(int.parse(userId));
        List<Map> landsMap = lands.map((land) => land.toMap()).toList();

        return Response.ok(jsonEncode(landsMap),
            headers: {'content-type': 'application/json'});
      } catch (e, s) {
        print(e);
        print(s);
      }
    });

    // router.get('/<userId>/lands', (Request req, String userId) async {
    //   var user = await _service.findOne(int.parse(userId));
    //   return Response.ok(jsonEncode(user));
    // });

    router.post('/<userId>/lands', (Request req, String userId) async {
      var body = await req.readAsString();
      await _service.save(LandsModel.fromJson(body));
      return Response(201);
    });

    router.put('/lands', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(LandsModel.fromJson(body));
      return result ? Response(200) : Response(500);
    });

    router.delete('/lands/<landId>', (Request req, String landId) async {
      await _service.delete(int.parse(landId));
      return Response.ok('Deletou a terra');
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
