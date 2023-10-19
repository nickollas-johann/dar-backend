import '../models.dart/lands_model.dart';
import '../utils/list_extension.dart';
import 'service_interface.dart';

class LandsService implements ServiceInterface<LandsModel> {
  
  List<LandsModel> fakeDB = [];
  @override
  Future<bool> delete(int id) async {
    fakeDB.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  Future<List<LandsModel>> findAll() async {
    return fakeDB;
  }

  @override
   Future<LandsModel?>findOne(int id) async {
    return fakeDB.firstWhere((element) => element.id == id);
  }

  @override
  Future<bool> save(LandsModel value)async {
    LandsModel? landsModel =
        fakeDB.firstWhereOrnull((element) => element.id == value.id);
    if (landsModel == null) {
      fakeDB.add(value);
    } else {
      var index = fakeDB.indexOf(landsModel);
      fakeDB[index] = value;
    }
    return true;
  }
}
