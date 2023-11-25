import '../dao/orders_dao.dart';
import '../models.dart/order_model.dart';
import 'service_interface.dart';

class OrdersService implements ServiceInterface<OrderModel> {
  final OrdersDAO _ordersDAO;

  OrdersService(this._ordersDAO);

  @override
  Future<bool> delete(int id) async {
    return await _ordersDAO.delete(id);
  }

  @override
  Future<List<OrderModel>> findAll(int id) async {
    return await _ordersDAO.getAll(id);
  }

  @override
  Future<OrderModel?> findOne(int id) async {
    return await _ordersDAO.getOne(id);
  }

  @override
  Future<bool> save(OrderModel value) async {
    if (value.orderId == null) {
      return await _ordersDAO.create(value);
    } else {
      return await _ordersDAO.update(value);
    }
  }
}
