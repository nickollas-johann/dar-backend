import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models.dart/order_model.dart';
import '../services/service_interface.dart';
import 'api.dart';

class OrdersApi extends Api {
  final ServiceInterface<OrderModel> _service;

  OrdersApi(this._service);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/<userId>/orders', (Request req, String userId) async {
      List<OrderModel> orders = await _service.findAll(int.parse(userId));
      List<Map> ordersMap = orders.map((order) => order.toMap()).toList();

      return Response.ok(jsonEncode(ordersMap),
          headers: {'content-type': 'application/json'});
    });

    router.post('/orders', (Request req) async {
      var body = await req.readAsString();
      _service.save(OrderModel.fromJson(body));
      return Response(201);
    });

    router.put('/orders', (Request req, String orderId) async {
      var body = await req.readAsString();
      var result = await _service.save(OrderModel.fromJson(body));
      return Response.ok(result);
    });

    router.delete('/orders/<orderId>', (Request req, String orderId) async {
      await _service.delete(int.parse(orderId));
      return Response.ok('Ordem deletada');
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
