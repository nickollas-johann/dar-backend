import '../infra/data/db_config.dart';
import '../models.dart/lands_model.dart';
import 'dao.dart';

class LandsDAO implements DAO<LandsModel> {
  final DBConfig _dbConfig;

  LandsDAO(this._dbConfig);
  @override
  Future<bool> create(LandsModel value) async {
    var results = await _dbConfig.execQuery(
        'INSERT INTO lands_table (lands_size, location, user_id) VALUES (?,?,?);',
        [value.landSize, value.location, value.userId]);
    return results.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var results = await _dbConfig
        .execQuery('DELETE from lands_table WHERE lands_id = ?;', [id]);

    return results.affectedRows > 0;
  }

  @override
  Future<List<LandsModel>> getAll(int userId) async {
    var results = await _dbConfig.execQuery(
        'SELECT * FROM farm_db.lands_table WHERE user_id = ?;', [userId]);
    return results
        .map((r) => LandsModel.fromMap(r.fields))
        .toList()
        .cast<LandsModel>();
  }

  @override
  Future<LandsModel?> getOne(int id) async {
    var results = await _dbConfig.execQuery(
        'SELECT * FROM farm_db.lands_table WHERE lands_id = ?;', [id]);
    return results.affectedRows == 0
        ? null
        : LandsModel.fromMap(results.first.fields);
  }

  @override
  Future<bool> update(LandsModel value) async {
    var results = await _dbConfig.execQuery(
        'UPDATE lands_table SET lands_size = ?, location = ? WHERE lands_id = ?;',
        [value.landSize, value.location, value.landsId]);

    return results.affectedRows > 0;
  }
}
