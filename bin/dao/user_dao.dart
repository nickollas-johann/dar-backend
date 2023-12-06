import 'package:mysql1/mysql1.dart';
import '../infra/data/db_config.dart';
import '../models.dart/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfig _dbConfig;

  UserDAO(this._dbConfig);
  @override
  Future<bool> create(UserModel value) async {
    var results = await _dbConfig.execQuery(
        'INSERT INTO user_table (user_name, user_email, user_password, user_type, user_cel, user_crea) VALUES (?,?,?,?,?,?);',
        [
          value.userName,
          value.userEmail,
          value.userPassword,
          value.userType,
          value.userCel,
          value.userCrea
        ]);
    return results.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var results = await
        _dbConfig.execQuery('DELETE from user_table WHERE user_id = ?;', [id]);

    return results.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> getAll(int id) async {
    ResultRow results = await
        _dbConfig.execQuery('SELECT * FROM farm_db.user_table WHERE user_id = ?;', [id]);
    return results
        .map((r) => UserModel.fromMap(r.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> getOne(int id) async {
    var results = await _dbConfig
        .execQuery('SELECT * FROM farm_db.user_table WHERE user_id = ?;', [id]);
    return results.affectedRows == 0
        ? null
        : UserModel.fromMap(results.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    var results = await _dbConfig.execQuery(
        'UPDATE user_table SET user_id = ?, user_password = ?, user_cel = ?;',
        [value.userId, value.userPassword, value.userCel]);

    return results.affectedRows > 0;
  }

  Future<UserModel?> getByEmail(String email) async {
    var results = await _dbConfig
        .execQuery('SELECT * FROM user_table WHERE user_email = ?;', [email]);
    return results.affectedRows == 0
        ? null
        : UserModel.fromEmail(results.first.fields);
  }
}
