import '../dao/culture_dao.dart';
import '../models.dart/culture_model.dart';
import 'service_interface.dart';

class CultureService implements ServiceInterface<CultureModel> {
  final CulturesDAO _culturesDAO;

  CultureService(this._culturesDAO);

  @override
  Future<bool> delete(int id) async {
    return await _culturesDAO.delete(id);
  }

  @override
  Future<List<CultureModel>> findAll(int id) async {
    return await _culturesDAO.getAll(id);
  }

  @override
  Future<CultureModel?> findOne(int id) async {
    return await _culturesDAO.getOne(id);
   
  }

  @override
  Future<bool> save(CultureModel value) async {
     if (value.cultureId == null) {
      return await _culturesDAO.create(value);
    } else {
      return await _culturesDAO.update(value);
    }
  }
}
