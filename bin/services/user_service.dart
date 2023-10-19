import 'package:password_dart/password_dart.dart';

import '../dao/user_dao.dart';
import '../models.dart/user_model.dart';
import 'service_interface.dart';

class UserService implements ServiceInterface<UserModel> {
  final UserDAO _userDAO;

  UserService(this._userDAO);
  @override
  Future<bool> delete(int value) async => await _userDAO.delete(value);

  @override
  Future<List<UserModel>> findAll() async => await _userDAO.getAll();

  @override
  Future<UserModel?> findOne(int id) async => await _userDAO.getOne(id);

  @override
  Future<bool> save(UserModel value) async {
    if (value.userId == null) {
      final hash = Password.hash(value.userPassword!, PBKDF2());
      value.userPassword = hash;

      return _userDAO.create(value);
    } else {
      return _userDAO.update(value);
    }
  }
  Future<UserModel?> findByEmail(String email) async => await _userDAO.getByEmail(email);
}
