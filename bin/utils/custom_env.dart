import 'dart:io';

import 'parser_extension.dart';

class CustomEnv {
  static Map<String, String> _map = {};
  static final String file = '.env';

  // CustomEnv._();

  // factory CustomEnv.fromFile(String file) {
  //   _file = file;
  //   return CustomEnv._();
  // }

  Future<Type> get<Type>({required String key}) async {
    if (_map.isEmpty) {
      await _load();
    }
    return _map[key]!.toType(Type);
  }

  Future<void> _load() async {
    List<String> lines = (await _readFile()).split('\n');
    _map = {for (var l in lines) l.split('=')[0]: l.split('=')[1]};
  }

  Future<String> _readFile() async {
    return await File(file).readAsString();
  }
}
