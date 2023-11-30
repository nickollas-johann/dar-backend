import '../dao/lands_dao.dart';
import '../models.dart/lands_model.dart';
import 'service_interface.dart';

class LandsService implements ServiceInterface<LandsModel> {
  final LandsDAO _landsDAO;

  LandsService(this._landsDAO);
  @override
  Future<bool> delete(int id) async {
    return await _landsDAO.delete(id);
  }

  @override
  Future<List<LandsModel>> findAll(int id) async {
    return await _landsDAO.getAll(id);
  }

  @override
  Future<LandsModel?> findOne(int id) async {
    return await _landsDAO.getOne(id);
  }

  @override
  Future<bool> save(LandsModel value) async {
    if (value.landsId == null) {
      return await _landsDAO.create(value);
    } else {
      return await _landsDAO.update(value);
    }
  }
}
