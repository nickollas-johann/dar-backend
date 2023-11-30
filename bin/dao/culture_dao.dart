import '../infra/data/db_config.dart';
import '../models.dart/culture_model.dart';
import 'dao.dart';

class CulturesDAO implements DAO<CultureModel> {
  final DBConfig _dbConfig;

  CulturesDAO(this._dbConfig);

  @override
  Future<bool> create(CultureModel value) async {
    var results = await _dbConfig.execQuery(
        'INSERT INTO culture_table (culture_name, culture_start, estimated_time, lands_id, culture_discription) VALUES (?,?,?,?,?)',
        [
          value.cultureName,
          value.cultureStart,
          value.estimatedTime,
          value.landId,
          value.cultureDiscription
        ]);
    return results.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var results = await _dbConfig
        .execQuery('DELETE from culture_table WHERE culture_id = ?;', [id]);

    return results.affectedRows > 0;
  }

  @override
  Future<List<CultureModel>> getAll(int id) async {
    var results =
        await _dbConfig.execQuery('SELECT * FROM farm_db.culture_table WHERE lands_id = ?;', [id]);
    return results
        .map((r) => CultureModel.fromMap(r.fields))
        .toList()
        .cast<CultureModel>();
  }

  @override
  Future<CultureModel?> getOne(int id) async {
    var results = await _dbConfig.execQuery(
        'SELECT * FROM farm_db.user_table u INNER JOIN lands_table l ON u.user_id = l.user_id INNER JOIN culture_table c ON l.lands_id = c.lands_id WHERE u.user_id = ?' [id]);
    return results.affectedRows == 0
        ? null
        : CultureModel.fromMap(results.first.fields);
  }

  @override
  Future<bool> update(CultureModel value) async {
    var results = await _dbConfig.execQuery(
        'UPDATE culture_table SET culture_id = ?, culture_name = ?, begin_time = ?, estimated_time = ?, lands_id = ?, culture_discription = ?',
        [
          value.cultureId,
          value.cultureName,
          value.cultureStart,
          value.estimatedTime,
          value.landId,
          value.cultureDiscription
        ]);

    return results.affectedRows > 0;
  }
}
