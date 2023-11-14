import '../../api/culture_api.dart';
import '../../api/lands_api.dart';
import '../../api/login_api.dart';
import '../../api/orders_api.dart';
import '../../api/user_api.dart';
import '../../dao/culture_dao.dart';
import '../../dao/lands_dao.dart';
import '../../dao/orders_dao.dart';
import '../../dao/user_dao.dart';
import '../../models.dart/culture_model.dart';
import '../../models.dart/lands_model.dart';
import '../../models.dart/order_model.dart';
import '../../services/culture_service.dart';
import '../../services/lands_service.dart';
import '../../services/login_service.dart';
import '../../services/orders_service.dart';
import '../../services/service_interface.dart';
import '../../services/user_service.dart';
import '../data/db_config.dart';
import '../data/mysql_db_config.dart';
import '../security/security_service.dart';
import '../security/secutiry_service_impl.dart';
import 'dependency_injector.dart';

class Injectors {
  Future<DependencyInjector> initialize() async {
    var di = DependencyInjector();

    di.register<DBConfig>(() => MySqlDBConfig());
    di.register<SecurityService>(() => SecurityServiceImpl());

    // Lands
    di.register<LandsDAO>(() => LandsDAO(di.get()));
    di.register<ServiceInterface<LandsModel>>(() => LandsService(di.get()));
    di.register<LandsApi>(() => LandsApi(di.get()));

    // User
    di.register<UserDAO>(() => UserDAO(di.get()));
    di.register<UserService>(() => UserService(di.get()));
    di.register<UserApi>(() => UserApi(di.get()));

    // Login
    di.register<LoginService>(() => LoginService(di.get()));
    di.register<LoginApi>(() => LoginApi(di.get(), di.get()));

    // Order
    di.register<OrdersDAO>(() => OrdersDAO(di.get()));
    di.register<ServiceInterface<OrderModel>>(() => OrdersService(di.get()));
    di.register<OrdersApi>(() => OrdersApi(di.get()));

    // Culture
    di.register<CulturesDAO>(() => CulturesDAO(di.get()));
    di.register<ServiceInterface<CultureModel>>(() => CultureService(di.get()));
    di.register<CulturesApi>(() => CulturesApi(di.get()));

    return di;
  }
}
