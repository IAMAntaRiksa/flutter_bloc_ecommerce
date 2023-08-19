import 'package:flutter_app_ecommerce/core/data/api.dart';
import 'package:flutter_app_ecommerce/core/data/base_api.dart';
import 'package:flutter_app_ecommerce/core/services/auth/auth_service.dart';
import 'package:flutter_app_ecommerce/core/services/product/product_service.dart';
import 'package:flutter_app_ecommerce/core/utils/token/token_utils.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Api>(Api());
  locator.registerLazySingleton(() => BaseAPI());
  locator.registerLazySingleton(() => ProductService(locator<BaseAPI>()));
  locator.registerSingleton(TokenUtils());
  locator.registerLazySingleton(() => AuthServices(locator<BaseAPI>()));
}
