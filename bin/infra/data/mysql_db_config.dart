import 'package:mysql1/mysql1.dart';

import '../../utils/custom_env.dart';
import 'db_config.dart';

class MySqlDBConfig implements DBConfig {
  MySqlConnection? _connection;
  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    print(await _connection!.query('SELECT * FROM farm_db.user_table;'));
    if (_connection == null) {
      throw Exception('ERROR/DB -> Failed to create connection');
    }
    return _connection!;
  }

  @override
  Future<MySqlConnection> createConnection() async =>
      await MySqlConnection.connect(
        ConnectionSettings(
          host: await CustomEnv().get<String>(key: 'server_address'),
          port: await CustomEnv().get<int>(key: 'db_port'),
          user: await CustomEnv().get<String>(key: 'db_user'),
          password: await CustomEnv().get<String>(key: 'db_pass'),
          db: await CustomEnv().get<String>(key: 'db'),
        ),
      );

  @override
  execQuery(String sql, [List? params]) async {
    var connection = await this.connection;
    return await connection.query(sql, params);
  }
}
