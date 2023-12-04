import 'dart:io';
import 'parser_extension.dart';

class CustomEnv {
  static Map<String, String> _map = {};
  static String _file = '../../.env';

  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }

  static Future<Type> get<Type>({required String key}) async {
    if (_map.isEmpty) {
      await _load();
    }
    return _map[key]!.toType(Type);
  }

  static Future<void> _load() async {
    List<String> lines = (await _readFile()).split('\n')
      ..removeWhere((element) => element.isEmpty);
    for (var l in lines) {
      var a = l.split('=')[0];
      var b = l.split('=')[1];

      print(a);
      print(b);
    }
  }

  static Future<String> _readFile() async {
    return await File(_file).readAsString();
  }
}
