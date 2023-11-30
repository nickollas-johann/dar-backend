import '../infra/data/db_config.dart';
import '../models.dart/order_model.dart';
import 'dao.dart';

class OrdersDAO implements DAO<OrderModel> {
  final DBConfig _dbConfig;

  OrdersDAO(this._dbConfig);

  @override
  Future<bool> create(OrderModel value) async {
    var results = await _dbConfig.execQuery(
        'INSERT INTO orders_table (user_id, professional_id, order_date, order_done) VALUES (?,?,?,?)',
        [value.userId, value.professionalId, value.orderDate, value.orderDone]);
    return results.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var results = await _dbConfig
        .execQuery('DELETE from orders_table WHERE order_id = ?;', [id]);

    return results.affectedRows > 0;
  }

  @override
  Future<List<OrderModel>> getAll(int id) async {
    var results =
        await _dbConfig.execQuery('SELECT * FROM farm_db.orders_table WHERE user_id = ?;', [id]);
    return results
        .map((r) => OrderModel.fromMap(r.fields))
        .toList()
        .cast<OrderModel>();
  }

  @override
  Future<OrderModel?> getOne(int id) async {
    var results = await _dbConfig.execQuery(
        'SELECT * FROM farm_db.orders_table WHERE orders_id = ?;', [id]);
    return results.affectedRows == 0
        ? null
        : OrderModel.fromMap(results.first.fields);
  }

  @override
  Future<bool> update(OrderModel value) async {
    var results = await _dbConfig.execQuery(
        'UPDATE orders_table SET order_id = ?, user_id = ?, professional_id = ?, order_date = ?, order_done = ?',
        [
          value.orderId,
          value.userId,
          value.professionalId,
          value.orderDate,
          value.orderDone
        ]);

    return results.affectedRows > 0;
  }
}
