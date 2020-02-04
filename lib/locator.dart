import 'package:get_it/get_it.dart';
import 'package:BridgeTeam/services/auth.dart';
GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerFactory(() => AuthService());

}