import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repositories/user_repository_impl.dart';
import '../data/repositories/jelly_bean_repository_impl.dart';
import '../data/resources/local_data_source_impl.dart';
import '../data/resources/database_helper.dart';
import '../data/resources/api_service.dart';
import '../domain/repositories/local_data_source.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/repositories/jelly_bean_repository.dart';
import '../domain/usecases/get_jelly_beans.dart';
import '../domain/usecases/login_user.dart';
import '../domain/usecases/register_user.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register SharedPreferences
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register DatabaseHelper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Register LocalDataSourceImpl as LocalDataSource with DatabaseHelper
  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(databaseHelper: locator<DatabaseHelper>()));

  // Register UserRepository with LocalDataSource and SharedPreferences
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
    localDataSource: locator<LocalDataSource>(),
    sharedPreferences: locator<SharedPreferences>(),
  ));

  // Register ApiService
  locator.registerLazySingleton<ApiService>(() => ApiService());

  // Register JellyBeanRepository with ApiService
  locator.registerLazySingleton<JellyBeanRepository>(() => JellyBeanRepositoryImpl(apiService: locator<ApiService>()));

  // Register use cases
  locator.registerLazySingleton(() => RegisterUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => LoginUser(locator<UserRepository>()));
  locator.registerLazySingleton(() => GetJellyBeans(locator<JellyBeanRepository>()));
}
