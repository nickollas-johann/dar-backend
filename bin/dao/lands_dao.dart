import '../infra/data/db_config.dart';
import '../models.dart/lands_model.dart';
import 'dao.dart';

class LandsDAO implements DAO<LandsModel> {
  final DBConfig _dbConfig;

  LandsDAO(this._dbConfig);
  @override
  Future<bool> create(LandsModel value) async {
    var results = await _dbConfig.execQuery(
        'INSERT INTO lands_table (lands_size, location) VALUES (?,?);', [
      value.landSize,
      value.location,
    ]);
    return results.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var results = await _dbConfig
        .execQuery('DELETE from lands_table WHERE lands_id = ?;', [id]);

    return results.affectedRows > 0;
  }

  @override
  Future<List<LandsModel>> getAll() async {
    var results =
        await _dbConfig.execQuery('SELECT * FROM farm_db.lands_table;');
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
        'UPDATE lands_table SET lands_id = ?, lands_size = ?, location = ?;',
        [value.landsId, value.landSize, value.location]);

    return results.affectedRows > 0;
  }
}
